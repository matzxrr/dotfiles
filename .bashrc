##############################################
# Matt Greenberg Bash
# ############################################

default_username='mattdevio'

# Not a ZSH script
if [[ -n "$ZSH_VERSION" ]]; then
    return 1 2> /dev/null || exit 1;
fi;

# Setup Glyphs
USER_ICON=''
PENGUIN_ICON=''
APPLE_ICON=''
FOLDER_ICON=''
SERVER_ICON=''
GIT_ICON=''
MULTI_FIRST='╭─'
MULTI_LAST='╰'

# Get Logo by System Type
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     MACHINE=$PENGUIN_ICON;;
    Darwin*)    MACHINE=$APPLE_ICON;;
    *)          MACHINE=$PENGUIN_ICON;;
esac


set_prompts() {

    # See the color table...
    # for c in {0..255}; do tput setaf $c; tput setaf $c | cat -v; echo =$c; done

    local black="" blue="" bold="" cyan="" green="" orange="" \
          purple="" red="" reset="" white="" yellow=""

    local dateCmd=""

    if [ -x /usr/bin/tput ] && tput setaf 1 &> /dev/null; then

        tput sgr0 # Reset colors

        bold=$(tput bold)
        reset=$(tput sgr0)

        black=$(tput setaf 000)
        red=$(tput setaf 001)
        green=$(tput setaf 002)
        yellow=$(tput setaf 003)
        blue=$(tput setaf 004)
        purple=$(tput setaf 005)
        teal=$(tput setaf 006)
        silver=$(tput setaf 007)
        charcoal=$(tput setaf 008)

    else

        bold=""
        reset="\e[0m"

        black="\e[1;000m"
        red="\e[1;001m"
        green="\e[1;002m"
        yellow="\e[1;003m"
        blue="\e[1;004m"
        purple="\e[1;005m"
        teal="\e[1;006m"
        silver="\e[1;007m"
        charcoal="\e[1;008m"

    fi

    # Only show username/host if not default
    function usernamehost() {

        userhost="${silver}$MULTI_FIRST"
        userhost+="${yellow} $MACHINE $USER "
        userhost+="${teal}at "
        userhost+="${purple}$SERVER_ICON $HOSTNAME "
        userhost+="${teal}in"

        if [ $USER != "$default_username" ]; then echo $userhost ""; fi
    }

    function prompt_git() {
        # check if we're in a git repo. (fast)
        git rev-parse --is-inside-work-tree &>/dev/null || return

        # Get branch Name
        branchName="$(git symbolic-ref HEAD 2>/dev/null)" || branchName="(unnamed branch)"     # detached HEAD
        branchName=${branchName##refs/heads/}

        # check if it's dirty
        if [[ -n $(git status --porcelain) ]]; then
            dirty="*";
        fi

        # mathias has a few more checks some may like:
        # github.com/mathiasbynens/dotfiles/blob/a8bd0d4300/.bash_prompt#L30-L43

        echo "${1}$GIT_ICON ${branchName}${2}$dirty";

        return
    }



    # ------------------------------------------------------------------
    # | Prompt string                                                  |
    # ------------------------------------------------------------------

    PS1="\[\033]0;\w\007\]"                                 # terminal title (set to the current working directory)
    PS1+="\n\[$bold\]"
    PS1+="\[$(usernamehost)\]"                              # username at host
    PS1+="\[$red\]$FOLDER_ICON \w"                                     # working directory
    PS1+="\$(prompt_git \"$teal on $yellow\" \"$cyan\")"   # git repository details
    PS1+="\n"
    PS1+="\[$silver\]$MULTI_LAST \[$reset\]"

    export PS1

    # ------------------------------------------------------------------
    # | Subshell prompt string                                         |
    # ------------------------------------------------------------------

    export PS2="\[$red\] \[$reset\]"

}

# ----------------------------------------------------------------------
# | Path Updates                                                       |
# ----------------------------------------------------------------------
export PATH=/opt/diff-so-fancy:$PATH
export PATH=/home/$USER/.local/share/bob/nvim-bin:$PATH
export PATH="$PATH:/home/$USER/.local/bin"
export PATH="$PATH:/usr/local/go/bin"

export BASH_SILENCE_DEPRECATION_WARNING=1
export HOMEBREW_BUNDLE_FILE=~/.config/.brewfile
export EDITOR=hx

export HELIX_RUNTIME="$HOME/helix/runtime"

set_prompts
unset set_prompts

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

RUSTUP="$HOME/.cargo/env"
if [ -f "$RUSTUP" ]; then
    . "$RUSTUP"
fi
unset RUSTUP

IE="$HOME/.ie"
if [ -f "$IE" ]; then
    . "$IE"
fi
unset IE

## My Aliases
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

