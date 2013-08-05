# Bugs:
#  the __prompt_statuschar else if bug. WTF!?
#  default keybindings erase all other bindings
#  same with default commands
#  can't multiline in (parens)
set fish_greeting ''

set -g XDG_CONFIG_HOME $HOME/.config
set -g XDG_CACHE_HOME $HOME/.cache
set -g XDG_DATA_HOME $HOME/.local/share
set -gx PATH $HOME/.cabal/bin $HOME/.local/bin $PATH

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
