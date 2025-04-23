{
  description = "Connor's system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
    # Keeps packages of this flake and nix-darwin flake in sync.
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.neovim
          pkgs.spotify
          pkgs.mkalias
          pkgs.starship
          # pkgs.ghostty is broken. See https://github.com/NixOS/nixpkgs/issues/388984
          pkgs.slack
          pkgs.raycast
          pkgs.jetbrains.idea-ultimate
          pkgs.cyberduck
          pkgs.inkscape
          pkgs.gnupg
          pkgs.pinentry_mac
          pkgs.podman
          pkgs.podman-compose
          pkgs.podman-desktop
          pkgs.zulu23
          pkgs.zulu17
          pkgs.zulu11
          pkgs.zoxide
          pkgs.eza
        ];


      homebrew = {
        enable = true;
        brews = [
          "mas"
        ];
        casks = [
          "ghostty"
          # Mac App Store
          "miro"
          "1password"
        ];
        masApps = {
          # Put Mac App Store apps here in format "Name" = <mac-app-store-id>;
        };
        onActivation.cleanup = "zap";
      };

      fonts.packages = [
          (pkgs.nerdfonts.override { fonts = ["JetBrainsMono"]; })
      ];

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

            system.defaults = {
        dock.autohide  = true;
        dock.persistent-apps = [
          "${pkgs.spotify}/Applications/Spotify.app"
          "${pkgs.slack}/Applications/Slack.app"
          "${pkgs.jetbrains.idea-ultimate}/Applications/IntelliJ IDEA.app"
          "/System/Applications/Mail.app"
          "/System/Applications/Calendar.app"
          "System/Applications/Ghostty.app"
        ];
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled  = false;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.KeyRepeat = 2;
      };
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfree = true;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#c0nn0r
    darwinConfigurations."c0nn0rstevens" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            # Apple Silicon Only
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "connor.stevens";

            autoMigrate = true;

          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."c0nn0rstevens".pkgs;
  };
}
