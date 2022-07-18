function zinit_load()
{
    zinit ice depth=1
    zinit light romkatv/powerlevel10k

    zinit ice lucid wait='0' atload='_zsh_autosuggest_start'
    zinit light zsh-users/zsh-autosuggestions

    zinit light zdharma/fast-syntax-highlighting

    # zinit snippet OMZ::lib/key-bindings.zsh

    zinit wait="1" lucid for \
        OMZ::plugins/sudo/sudo.plugin.zsh \
        OMZ::lib/completion.zsh \
        OMZ::lib/clipboard.zsh \
        OMZ::plugins/autojump/autojump.plugin.zsh \
        fdw/ranger_autojump

    zinit wait="1" lucid light-mode for \
        hlissner/zsh-autopair \
        hchbaw/zce.zsh \
        Aloxaf/gencomp \
        OMZ::plugins/npm/npm.plugin.zsh
        # wfxr/forgit

    zinit light-mode blockf  for \
        zsh-users/zsh-completions \
        src="etc/git-extras-completion.zsh" \
            tj/git-extras
        # as="program" atclone="rm -f ^(rgg|agv)" \
        #     lilydjwg/search-and-view \
        # atclone="dircolors -b LS_COLORS > c.zsh" atpull='%atclone' pick='c.zsh' \
        #     trapd00r/LS_COLORS \

    zinit ice mv=":cht.sh -> cht.sh" atclone="chmod +x cht.sh" as="program"
    zinit snippet https://cht.sh/:cht.sh

    zinit ice mv=":zsh -> _cht" as="completion"
    zinit snippet https://cheat.sh/:zsh

    if [ -f /usr/bin/svn ]
    then
        zinit ice svn
        zinit snippet OMZ::plugins/pip
else
	echo "Install subversion!"
    fi

    zinit light-mode for \
        zdharma-continuum/zinit-annex-as-monitor \
        zdharma-continuum/zinit-annex-bin-gem-node \
        zdharma-continuum/zinit-annex-patch-dl \

}

if ! [ -d ~/.local/share/zinit/ ]
then
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

if ! [ -f /usr/bin/envsubst ]
then
	echo "Install gettext!"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.variables

# Disable insecure directory check
export ZSH_DISABLE_COMPFIX=true

# Grep configurations.
GREP_OPTIONS="--color=auto --exclude=$EXC_FOLDERS"
EXC_FOLDERS="{.bzr,CVS,.git,.hg,.svn,.idea,.tox}"
alias grep="grep $GREP_OPTIONS"
alias egrep="egrep $GREP_OPTIONS"
alias fgrep="fgrep $GREP_OPTIONS"
alias down="vim /home/hhz/syncthing/local_sync/便签.md"

# Zsh-autosuggest configurations
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_COMPLETION_IGNORE='( |man |pikaur -S )*'

# History command configuration
HISTFILE="$HOME/.zsh_history" # Where the file is.
HISTSIZE=1000 # How large is the file.
SAVEHIST=200 # How many entries will the zsh save before write to the history file.
# setopt SHARE_HISTORY # R/W history file on every single command.
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it

# Enable auto-correction
setopt correct_all

## jobs
setopt long_list_jobs

# recognize comments
setopt interactivecomments

# Colors
#darkgrey="$(tput bold ; tput setaf 0)"
#white="$(tput bold ; tput setaf 7)"
#blue="$(tput bold; tput setaf 4)"
#cyan="$(tput bold; tput setaf 6)"
#nc="$(tput sgr0)"
#export PS1="\[$blue\][ \[$cyan\]\H \[$darkgrey\]\w\[$darkgrey\] \[$blue\]]\\[$darkgrey\]# \[$nc\]"

autoload -Uz is-at-least
zmodload zsh/langinfo

# *-magic is known buggy in some versions; disable if so
if [[ $DISABLE_MAGIC_FUNCTIONS != true ]]; then
  for d in $fpath; do
    if [[ -e "$d/url-quote-magic" ]]; then
      if is-at-least 5.1; then
        autoload -Uz bracketed-paste-magic
        zle -N bracketed-paste bracketed-paste-magic
      fi
      autoload -Uz url-quote-magic
      zle -N self-insert url-quote-magic
    break
    fi
  done
fi


# Use the ladder to update
alias u="export ALL_PROXY='socks5://127.0.0.1:10808'; zinit update; unset ALL_PROXY"

alias halt="shutdown now"
alias sl="ls"
alias config="vim $HOME/.zshrc"
alias vim="nvim"
alias vi="nvim"
alias hibrenate="shutdown now"
alias battery="cat /sys/class/power_supply/BAT0/capacity"
alias -s py=python
alias -s class=java
alias neo="proxychains nvim $HOME/.config/nvim/init.vim"
alias edit="nvim --noplugin"
alias sou='source ~/.zshrc'
alias hexo='./node_modules/hexo/bin/hexo'
alias shred="shred -zf"
alias wget="wget -U 'noleak'"
alias curl="curl --user-agent 'noleak'"
alias xcopy="xclip -selection clipboard"
alias xpaste="xclip -selection clipboard -o"
alias nc="ncat"
alias open="xdg-open"
alias netd="sudo airmon-ng check kill"
alias diary="cd ~/scefuvh_blog/HongRed/;vim source/_diaries/`date +%Y-%m-%d`.md;cd -"
alias c="feh /home/hhz/temp/classtable.png"
alias mjava='mvn exec:java -Dexec.mainClass="hhz.App"'
alias wiki='wiki-search-html'
alias ls='ls --color=auto'
alias e='feh /home/hhz/temp/exams.png'
alias z='vim /home/hhz/syncthing/local_sync/便签.md'
alias umnt='sudo umount /mnt'

# Turn off the beep
if [ "${TERM}" = "linux" ]
then
    setterm -blength 0
fi

### Added by Zinit's installer
if [[ ! -f "$HOME"/.zinit/bin/zinit.zsh ]]; then
    rm -rf "$HOME"/.zinit/
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone -b main https://github.com/zdharma-continuum/zinit.git "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

zinit_load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zpcompinit; zpcdreplay

# For autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select

# For autocompletion of command line switches for aliases
setopt COMPLETE_ALIASES

# For enabling autocompletion of privileged environments in privileged commands
zstyle ':completion::complete:*' gain-privileges 1

# Key Bindings
# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
  bindkey -M emacs "${terminfo[kpp]}" up-line-or-history
  bindkey -M viins "${terminfo[kpp]}" up-line-or-history
  bindkey -M vicmd "${terminfo[kpp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
  bindkey -M emacs "${terminfo[knp]}" down-line-or-history
  bindkey -M viins "${terminfo[knp]}" down-line-or-history
  bindkey -M vicmd "${terminfo[knp]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey ' ' magic-space                               # [Space] - don't do history expansion

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# file rename magick
bindkey "^[m" copy-prev-shell-word

# Use emacs key bindings
bindkey -e


source ~/.zsh_functions

if [ -f ~/.zsh_profile ]
then
    source ~/.zsh_profile
fi


# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
### End of Zinit's installer chunk

# Disable instant prompt error message.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
