#!/usr/bin/env fish

if status --is-interactive
    # Aliases
    alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
end
