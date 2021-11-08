#!/usr/bin/env zsh

#
# No plugin manager is needed to use this file. All that is needed is adding:
#   source {where-zew-is}/zsh-editing-workbench.plugin.zsh
#
# to ~/.zshrc.
#

0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"
ZEW_REPO_DIR="${0:h}"
CONFIG_DIR="$HOME/.config/zew"

#
# Update FPATH if:
# 1. Not loading with a plugin manager
# 2. Not having fpath already updated
#

if [[ ${zsh_loaded_plugins[-1]} != */zsh-editing-workbench && -z ${fpath[(r)${0:h}]} ]]
then
    fpath+=( "${0:h}" )
fi

#
# Copy configs
#

if ! test -d "$HOME/.config"; then
    mkdir "$HOME/.config"
fi

if ! test -d "$CONFIG_DIR"; then
    mkdir "$CONFIG_DIR"
fi

set zew.conf

local i
for i; do
    if ! test -f "$CONFIG_DIR/$i"; then
        cp "$ZEW_REPO_DIR/.config/zew/$i" "$CONFIG_DIR"
    fi
done

#
# Configure Zsh
#

. "$CONFIG_DIR"/zew.conf

autoload -Uz zew-backward-kill-shell-word zew-transpose-shell-words zew-rotate-shell-words select-word-style zew

# Below are configured:
# 1. Alt-w to kill a shell word
# 2. Alt-t to transpose shell words
# 3. Alt-m to copy previous shell word, or word before that, etc.
# 4. Alt-M to just copy previous shell word
# 5. Alt-. to copy last shell word from previous line, or line before that
# 6. Ctrl-W to kill word according to configured style
# 7. Alt-y to transpose words according to configured style
# 8. Alt-/ to complete word from history
# 9. Alt-h to complete word from history (custom version)
# 10. Ctrl-J to break line
# 11. To undo
# 12. Alt-r to rotate shell words right

# 1. Alt-w to kill a shell word
zle -N zew-backward-kill-shell-word
bindkey '^[w' zew-backward-kill-shell-word

# 2. Alt-t to transpose shell words
zle -N zew-transpose-shell-words
bindkey '^[t' zew-transpose-shell-words

# 3. Alt-m to copy previous shell word, or word before that, etc.
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word

# 4. Alt-M to just copy previous shell word
bindkey "^[M" copy-prev-shell-word

# 5. Alt-. to copy last shell word from previous line, or line before that
bindkey "^[." insert-last-word

# Select chosen word style
[[ $zew_word_style = (bash|normal|shell|bash|whitespace|default) ]] || zew_word_style=normal

WORDCHARS+=":\"'←↓→↑…«»≤≥„”’©½–"
select-word-style "$zew_word_style"

# 6. Ctrl-W to kill word according to configured style
bindkey "^W" backward-kill-word

# 7. Alt-y to transpose words according to configured style (cursor needs to be placed on beginning of word to swap)
autoload -Uz transpose-words-match
zle -N transpose-words-match
bindkey "^[y" transpose-words-match

# 8. Alt-/ to complete word from history
setopt hist_lex_words
bindkey "^[/" _history-complete-older
zstyle ':completion:history-words:*' remove-all-dups true
zstyle ':completion:history-words:*' sort true
zstyle ':completion:*' range 50000:10000 # TODO: from configuration

# 9. Complete word from history (custom version)
autoload zew-history-complete-word
zle -N zew-history-complete-word
zle -N zew-history-complete-word-backwards zew-history-complete-word
bindkey "^[h" zew-history-complete-word
bindkey "^[H" zew-history-complete-word-backwards

# 10. Break line
if [[ "$MC_SID" != "" || "$MC_CONTROL_PID" != "" ]]; then
    bindkey "^J" accept-line
else
    bindkey "^J" self-insert
fi

# 11. Undo
bindkey "^_" undo

# 12. Alt-r to rotate shell words right
zle -N zew-rotate-shell-words
zle -N zew-rotate-shell-words-backwards zew-rotate-shell-words
bindkey '^[r' zew-rotate-shell-words
bindkey '^[R' zew-rotate-shell-words-backwards
