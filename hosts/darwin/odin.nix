{
  user,
  lib,
  pkgs,
  ...
}:

let
  username = user.username;
in
{
  imports = [
    ./common
  ];

  # === Additional nix packages for Odin ===
  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      qmk
    ]
  );

  # === Common Homebrew Configuration Overwrite ===
  # Check what the defaults are in ./common/default.nix
  homebrew = {
    brews = lib.mkAfter [
      "docker"
    ];
    casks = lib.mkAfter [
      # Extends the cask list in the common configuration
      "macs-fan-control"
      "calibre"
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
    # This overrides what's configured in common/default.nix
    defaults = {
      dock = {
        tilesize = 48;
      };
    };
  };
}
