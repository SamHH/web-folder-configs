# Fish configuration
fish_vi_key_bindings
set fish_greeting

# Exported variables
## Use Nvim as editor wherever possible
set -x VISUAL nvim
set -x EDITOR $VISUAL

## Inform shell environment of preexisting ssh-agent socket
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

## Use taskrc outside of home dir
set -x TASKRC ~/.config/task/config

## Don't store less pager history
set -x LESSHISTFILE /dev/null

# Extend PATH for ghcup and Cabal (Haskell), and Yarn (PureScript)
set -a fish_user_paths ~/.ghcup/bin/ ~/.cabal/bin/ ~/.yarn/bin/

# Command drop-in replacement aliases
abbr vi 'nvim'
abbr top 'gotop'
abbr mpc 'vimpc'

# Arch package management-specific aliases
abbr in 'sudo pacman -S'
abbr ina 'sudo aura -A'
abbr up 'sudo pacman -Syu; and sudo aura -Auk'
abbr un 'sudo pacman -Rs'

# Misc/specific aliases
abbr todo 'clear; and task todo'

# Create directory path and cd into it
function mkcd
    mkdir -p $argv;
    cd $argv;
end

