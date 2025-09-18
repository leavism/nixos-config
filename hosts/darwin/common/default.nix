/*
=== Configuration for All macOS Devices ===
*
* Sensible defaults for all my macOS machines.
*/
{ pkgs, lib, user,... }:
let username = user.username; in
{
  imports = [
    ../../shared
  ];

  system = {
    stateVersion = 4;
    primaryUser = username;
    checks.verifyNixPath = false;

    defaults = {
      # https://mynixos.com/nix-darwin/options/system.defaults.finder
      finder = {
        NewWindowTarget = "Home"; # Default folder shown in Finder
        ShowExternalHardDrivesOnDesktop = false;
        ShowMountedServersOnDesktop = false;
        FXPreferredViewStyle = "Nlsv"; # Default Finder view
      };

      NSGlobalDomain = {
        # https://mynixos.com/nix-darwin/options/system.defaults.NSGlobalDomain
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # Lower is faster
        KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 15; # Values: 120, 94, 68, 35, 25, 15

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        # https://mynixos.com/nix-darwin/options/system.defaults.dock
        autohide = true;
        autohide-time-modifier = 0.2;

        show-recents = false;
        launchanim = true;
        orientation = "left";
        tilesize = 48;
        persistent-apps = [
          "/System/Cryptexes/App/System/Applications/Safari.app"
          "/Applications/Zen.app"
          "/System/Applications/Messages.app/"
          "/System/Applications/iPhone Mirroring.app/"
          "/Applications/Obsidian.app"
          "/Applications/Todoist.app/"
        ];
        
        persistent-others = [
          "/Users/${user.username}/Sync"
          "/Users/${user.username}/Downloads"
        ];
        # https://mynixos.com/nix-darwin/option/system.defaults.dock.wvous-bl-corner
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
      };
    };
  };

  # === Services ===
  # Syncthing service is in homemanager below
  
  services.tailscale.enable = true;
  
  services.jankyborders = {
    enable = true;
    hidpi = true;
    active_color = "0xFF89B4FA";
    inactive_color = "0x00";
    width = 10.0;
  };

  nix = {
    package = pkgs.nix;
    settings = {
      trusted-users = [ "@admin" "${username}" ];
      substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    # Garbage collection
    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [
    # System packages here. 
    # For macOS hosts, keep this to only terminal packages. GUI packages installed via
    # are semi-permanently and removing them is tedious.
    dockutil # declarative
  ] ++ (import ../../shared/packages.nix { inherit pkgs; });


  # It me
  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = lib.mkForce true;
    onActivation.cleanup = lib.mkDefault "zap";
    brews = [
      # TODO: Go back to stable release after October 2025
      { 
        name = "borders"; 
        args = "HEAD";
      }
      "tpm"
      "gh"
      "nvm"
    ];
    casks = [
      "font-geist-mono-nerd-font"
      "appcleaner"
      
      "ghostty"
      "visual-studio-code"
      "zen"

      "zoom"
      "slack"
      "splashtop-business"
      "microsoft-teams"
      "1password"

      "bitwarden"
      "logi-options+"
      "figma"
      "discord"

      "adguard"
      "transmission"
      "sensei"
      "keka"
      "cleanshot"
      "homerow"
      "aerospace"
      "obsidian"
    ];
    masApps = {
      "Goodnotes 6" = 1444383602;

      "Fantastical" = 975937182;
      "Microsoft OneNote" = 784801555;
      "OneDrive" = 823766827;
      "Microsoft Excel" = 462058435;
      "Microsoft Outlook" = 985367838;
      "Microsoft Word" = 462054704;
      "Microsoft PowerPoint" = 462062816;
    };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${username} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ../../shared/packages.nix {};
        stateVersion = "23.11";
      };
      programs = {
        # Overwrite and extend the shared home-manager configurations here
        # Example:
        # git = darwinHomeManager.git // { # Don't forget to merge into darwinHomeManager.git
        #   userName = "overrideUserName";  # This overrides the shared config
        # };
      } // import ../../shared/home-manager.nix { inherit config pkgs lib user; };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;

      services.syncthing = {
        enable = true;
      };
    };
  };
}
