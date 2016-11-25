set fish_greeting ''

set -gx PATH /usr/texbin $PATH
set -gx PATH $HOME/Code/anaconda2/bin $HOME/Code/anaconda3/bin /usr/texbin $PATH
set -gx PATH $HOME/.cabal/bin $PATH
set -gx PATH $HOME/.local/bin $PATH

set -g XDG_CONFIG_HOME $HOME/.config
set -g XDG_CACHE_HOME $HOME/.cache
set -g XDG_DATA_HOME $HOME/.local/share

set -gx EDITOR nvim
set -gx SUDO_EDITOR nvim
set -gx PYTHONSTARTUP $HOME/.config/python/startup.py

set -g __prompt_fg_sep (set_color cyan)
set -g __prompt_fg_user (set_color magenta)
set -g __prompt_fg_at (set_color white)
set -g __prompt_fg_host (set_color yellow)
set -g __prompt_fg_path (set_color green)

set -g __prompt_fg_mux (set_color blue)

set -g __prompt_fg_branch (set_color magenta)
set -g __prompt_fg_prompt (set_color cyan)

set -g __prompt_fg_weekday (set_color magenta)
set -g __prompt_fg_time (set_color cyan)

set -g __prompt_fg_charging (set_color blue)
set -g __prompt_fg_good (set_color green)
set -g __prompt_fg_warning (set_color yellow)
set -g __prompt_fg_bad (set_color red)
set -g __prompt_fg_urgent (set_color -o white)
set -g __prompt_bg_urgent (set_color -b red)

set -g __prompt_reset (set_color normal)

alias e "nvim"
alias o "nvr -c 'doau BufEnter'"

# We set all these manually so that they use the system colors, which will be
# set to look all pretty by either nvim or a base16 term profile.
set -g fish_color_autosuggestion yellow
set -g fish_color_command blue
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_error red
set -g fish_color_escape cyan
set -g fish_color_history_current cyan
set -g fish_color_match cyan
set -g fish_color_normal normal
set -g fish_color_operator cyan
set -g fish_color_param cyan
set -g fish_color_quote brown
set -g fish_color_redirection normal
set -g fish_color_search_match --background purple
set -g fish_color_valid_path --underline
set -g fish_pager_color_completion normal
set -g fish_pager_color_description yellow
set -g fish_pager_color_prefic cyan
set -g fish_pager_color_progress cyan

set -gx FZF_DEFAULT_OPTS '--color fg:-1,fg+:-1,bg:-1,bg+:-1,hl:2,hl+:2,pointer:4,prompt:4,info:5,spinner:5'
