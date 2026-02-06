/*
  === Home-Manager Configurations Cross-Platform ===

  https://nix-community.github.io/home-manager/index.xhtml

  Home Manager is a Nix-powered tool for reproducible management of the
  contents of users’ home directories. This includes programs, configuration
  files, environment variables, and arbitrary files.
*/
{
  pkgs,
  lib,
  user,
  ...
}:

let
  name = user.fullName;
  username = user.username;
  email = user.email;
in
{
  git = {
    enable = true;
    ignores = [
      "*.swp"
      ".DS_Store"
    ];
    lfs = {
      enable = true;
    };
    settings = {
      init.defaultBranch = "main";
      core = {
        editor = "vim";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;
      user.name = name;
      user.email = email;
    };
  };

  ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [
      "~/.ssh/config_external"
    ];
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
