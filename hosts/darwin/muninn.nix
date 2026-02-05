# === Muninn Configuration ===
# Custom configuration for my MacBook Air. The device lacks a fan and so the applications
# kept on here tend to be less system intensive.
{ user, ... }:
{
  imports = [
    ./common
  ];

  # === Common Homebrew Configuration Overwrite ===
  # Check what the defaults are in ./common/default.nix
  homebrew = {
    casks = [
      # Extends the cask list in the common configuration
      "swish"
      "alcove" # Notch app
      "aldente" # Battery management https://apphousekitchen.com/
      "hammerspoon"
    ];
    masApps = {
      # Extends the cask list in the common configuration
      # Quickly look up Mac App Store names and IDs with:
      # $ nix shell nixpkgs#mas
      # $ mas search <app name>
    };
  };

  system = {
    stateVersion = 4;
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
        tilesize = 40;
      };
    };
  };
}
