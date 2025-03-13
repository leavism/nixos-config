{ config, user,... }:

let username = user.username; in
{
  imports = [
    ./common
    ./common/dock
  ];

  # === Common Homebrew Configuration Overwrite ===
  # Check what the defaults are in ./common/default.nix
  homebrew = {
    brews = [
      "docker"
    ];
    casks = [
      # Extends the cask list in the common configuration
      "macs-fan-control"
    ];
    masApps = {
      # Extends the cask list in the common configuration
      # Quickly look up Mac App Store names and IDs with:
      # $ nix shell nixpkgs#mas
      # $ mas search <app name>
      "Final Cut Pro" = 424389933;
      "Compressor" = 424390742;
    };
  };

  system = {
    stateVersion = 4;
    checks.verifyNixPath = false;

    defaults = {
      finder = {
        NewWindowTarget = "Home";
        FXPreferredViewStyle = "Nlsv";
      };
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 15; # Values: 120, 94, 68, 35, 25, 15

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = false;
        show-recents = false;
        launchanim = true;
        orientation = "left";
        tilesize = 40;
      };
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = true;
  local.dock.entries = [
    { path = "/System/Cryptexes/App/System/Applications/Safari.app"; }
    { path = "/Applications/Zen Browser.app"; }
    { path = "/System/Applications/Messages.app/"; }
    { path = "/System/Applications/iPhone Mirroring.app/"; }
    { path = "/Applications/Obsidian.app"; }
    {
      path = "${config.users.users.${username}.home}/Downloads";
      section = "others";
      options = "--sort dateadded --view grid --display stack";
    }
  ];
}
