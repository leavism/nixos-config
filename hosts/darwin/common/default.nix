{ config, pkgs, lib, user,... }:

let username = user.username; in
{
  imports = [
    ../../shared
  ];

  services.nix-daemon.enable = true;
  services.jankyborders.enable = true;

  nix = {
    package = pkgs.nix;
    settings = {
      trusted-users = [ "@admin" "${username}" ];
      substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [
    # System packages here
    # For macOS hosts, keep this to only terminal packages.
    # GUI packages will be installed semi-permanently and removing them is tedious.
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
      "borders"   
    ];
    casks = [
      "font-geist-mono-nerd-font"
      
      "ghostty"
      "visual-studio-code"
      "zen-browser"

      "zoom"
      "slack"
      "splashtop-business"
      "microsoft-teams"
      "craft"
      "1password"

      "bitwarden"
      "figma"
      "discord"

      "adguard"
      "transmission"
      "sensei"
      "keka"
      "cleanshot"
      "raycast"
      "homerow"
      "aerospace"
      "obsidian"
    ];
    masApps = {
      "Things" = 904280696;
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
    };
  };
}
