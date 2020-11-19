#!/usr/bin/env fish

if status --is-interactive
    # Aliases
    alias dotfiles='/usr/bin/git --git-dir=$HOME/.git --work-tree=$HOME'
end
