# dotfiles

My personal dotfiles for [NixOS](https://nixos.org). Keybindings are with [my keymap](https://git.sr.ht/~samhh/qmk_firmware/tree/samhh/item/keyboards/ergodox_ez/keymaps/samhh/README.md) in mind.

## Usage

Do this once: `# ln -s /path/to/repo/configuration.nix /etc/nixos/`

Only the entrypoint module needs symlinking. Nix resolves relative imports at the module's real path.

For now a few parts of the config presume the repo will be at `~/dotfiles/`. Anything that couldn't be configured in Home Manager lives in `:/cfg/`.

## History

I used to use Arch and macOS, as well as run a custom XMonad config. Those configs are preserved in this repo's commit history.
