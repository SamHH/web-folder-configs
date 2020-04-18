# dotfiles

My personal dotfiles and miscellaneous configs.

## Overview

I spend most of my personal time on the Arch partition of my Macbook, however my work laptop is stuck with macOS. As such, I've tried to make working with both of these simultaneously as seamless as possible. For example, my experience in the terminal and the editor should be close to identical on each OS. The colour scheme I've tried to utilise where possible is [Nord](https://www.nordtheme.com).

## Project Structure

At its core, everything is split up into four basic dirs:

- **Linux**
- **macOS**
- **Shared**: Configs that should work out of the box on both Linux and macOS.
- **Controller**: Configs for my home "controller", an always-on Raspberry Pi that I primarily use to interface with my NAS.

You can use the included `./link.sh` helper on Linux/macOS to automatically set up syslinks for all configs. This uses Stow under the hood. Note that this does not apply to Controller configs.

Any configs that belong outside of the user home directory or require user input due to user secrets (e.g. GPG key in Git config) are placed in appended *_manual* dirs, separately from the clean configs. You will need to manually manage these.

There are plenty of software prerequisites as these are the configs I use every day down to a byte. Read the files you're downloading to understand what they are and what might be required for them to work.

