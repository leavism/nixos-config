/*
 * === Nix Packages Shared Cross-Platform ===
 *
 * For proper macOS compatibility, only put terminal packages. Any GUI packages
 * will be semi-permanent on macOS and is tedious to remove when longer needed.
 */
{ pkgs }:
with pkgs; [
  # Nix packages here
  git
  zsh
  tmux
  neovim

  eza
  oh-my-posh

  nodenv
  pyenv
]
