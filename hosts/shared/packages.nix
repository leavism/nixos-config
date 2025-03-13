/*
 * === Nix Packages Shared Cross-Platform ===
 *
 * For easier macOS compatibility, only put terminal packages. Any GUI packages
 * will be semi-permanent on macOS and is tedious to remove when no longer needed.
 */
{ pkgs }:
with pkgs; [
  # Nix packages here
  git
  zsh
  chezmoi
  tmux
  neovim
  sesh
  zoxide
  fzf
  gum
  lazygit
  eza
  oh-my-posh
  cargo # For some Mason packages
  pyenv
]
