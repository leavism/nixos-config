# Nix Config for macOS and NixOS

This was originally generated from [dustinlyons/nixos-config](https://github.com/dustinlyons/nixos-config), which is arguably *the best* nix configuration template available. However, I've changed my nix configs so much it doesn't even resemble the original by dustinlyons anymore.

## Layout

```
nixos-config/
├── apps                        # Nix commands to bootstrap and build configurations.
├── home                        # My configurations.
│   ├── darwin                  # MacOS/nix-darwin configurations.
│   │   ├── common              # Common configurations between all macOS machines.
│   │   └── (hostname).nix      # Per device configurations.
│   ├── nixos                   # NixOS configurations.
│   └── shared                  # Cross-platform shared configurations.
└── overlays                    # Drop an overlay file in this dir, and it runs.
```

## Work in progress
>
> [!CAUTION]
> The installation and setup instructions are WIP as they are a copy of the instructions from [dustinlyons/nixos-config](https://github.com/dustinlyons/nixos-config).
>
> For now (December 2024) they do not reflect the changes I've made and may not work properly.
> Here's what still needs to be done to better document the set up process:
>
> - [ ] Provide instructions on how to add a new user into the configurations. This should be [step 5](#5-apply-your-current-user-info).
>   - [ ] Maybe rewrite the `.#apply` command entirely.
> - [ ] Provide instructions on how to add a new hostname/device into the configurations.
> - [ ] Provide documentation on how packages are declared.
> - [x] Put in my dot file configurations (maybe?). I wouldn't mind continuing to use chezmoi to manage my dot files.
> - [ ] Check if this works on a NixOS host.

## Installation and Setup

## For macOS

### 1. Install dependencies

```sh
xcode-select --install
```

### 2. Install Nix

Install Nix with the Lix Systems installer with default values for any of the prompts.

```sh
curl -sSf -L https://install.lix.systems/lix | sh -s -- install --nix-build-group-id 30000
```

After installation, open a new terminal session to make the `nix` executable available in your `$PATH`. You'll need this in the steps ahead.

### 3. Clone this repo into your home directory

```sh
cd ~ && git clone https://github.com/leavism/nix-config.git
```

and then `cd` into the project directory.

```sh
cd nixos-config
```

### 4. Make `apps` commands executable

Make sure you're running this inside the project directory as it will not provide any feedback on failure nor success.

```sh
find apps/$(uname -m | sed 's/arm64/aarch64/')-darwin -type f \( -name apply -o -name build -o -name build-switch -o -name create-keys -o -name copy-keys -o -name check-keys \) -exec chmod +x {} \;
```

> [!WARNING]
> The steps beyond here are subject to change and may not work on all systems. Refer to the [WIP message](#work-in-progress) for more details.

### ~~5. Apply your current user info~~

~~Run this Nix command to replace stub values with your system properties, username, full name, and email.~~

```sh
nix run .#apply
```

> [!IMPORTANT]
> Users are now manually entered into [flake.nix](flake.nix) under `usersList`.

### 6. Build your configurations

Ensure nix will build your configuration before deploying your configurations with this command.

```sh
nix run .#build <hostname>
```

> [!NOTE]
> If this command doesn't work, then step 4 wasn't done correctly as this is one of the `apps/` commands that needs to be executable.

### 7. Apply changes

To apply your configurations to your system, run:

```sh
nix run .#build-switch <hostname>
```
