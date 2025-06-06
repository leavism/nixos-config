/*
  === Nix Packages Shared Cross-Platform ===
 *
 * For easier macOS compatibility, only put terminal packages. Any GUI packages
 * will be semi-permanent on macOS and is tedious to remove when no longer needed.
 */
{ pkgs }:
with pkgs; [
  # General development
  zsh
  oh-my-posh
  git
  tmux
  sesh
  zoxide
  fzf
  gum
  eza
  ripgrep
  pyenv
  tailscale
  
  # Configurations
  chezmoi
  
  # Nvim configurations
  neovim
  lazygit
  cargo # For some Mason packages
]
