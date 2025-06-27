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
      "todoist"
    ];
    masApps = {
      # Extends the cask list in the common configuration
      # Quickly look up Mac App Store names and IDs with:
      # $ nix shell nixpkgs#mas
      # $ mas search <app name>
    };
  };
}
