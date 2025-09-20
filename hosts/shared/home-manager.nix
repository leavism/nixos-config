/*
 * === Home-Manager Configurations Cross-Platform ===
 *
 * https://nix-community.github.io/home-manager/index.xhtml
 *
 * Home Manager is a Nix-powered tool for reproducible management of the
 * contents of users’ home directories. This includes programs, configuration
 * files, environment variables, and arbitrary files.
 */
{ pkgs, lib, user, ... }:

let name = user.fullName;
    username = user.username;
    email = user.email;
in
{
  git = {
    enable = true;
    ignores = [ "*.swp" ".DS_Store"];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "vim";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${username}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${username}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identitiesOnly = true;
        identityFile = "/Users/${username}/.ssh/id_ed25519";
        };
    };
  };
}
