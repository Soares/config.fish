set fish_greeting ''

function is_nixos
  [ -e /etc/os-release ] && grep 'NAME=NixOS' /etc/os-release > /dev/null
end

if ! is_nixos
  set -gx PATH /bin /sbin
  set -gx PATH /usr/bin /usr/sbin $PATH
  set -gx PATH /usr/local/bin /usr/local/sbin $PATH
  set -gx PATH $HOME/.local/bin $PATH
end

set -g XDG_CONFIG_HOME $HOME/.config
set -g XDG_CACHE_HOME $HOME/.cache
set -g XDG_DATA_HOME $HOME/.local/share

if test -n "$NVIM_LISTEN_ADDRESS"
	alias h "nvr -c 'doau BufEnter' -o"
	alias v "nvr -c 'doau BufEnter' -O"
	alias t "nvr -c 'doau BufEnter' --remote-tab"
	alias o "nvr -c 'doau BufEnter'"
	alias neovim 'command nvim'
	alias nvim "echo 'You\'re already in nvim. Consider using o, h, v, or t instead. Use \'neovim\' to force.'"
else
  alias o 'nvim'
end
set -gx EDITOR 'nvim'
set -gx SUDO_EDITOR nvim

set -g theme_date_format "+%H:%M"
set -g theme_nerd_fonts yes

# We set all these manually so that they use the system colors, which will be
# set to look all pretty by either nvim or a base16 term profile.
# set -g fish_color_autosuggestion yellow
# set -g fish_color_command blue
# set -g fish_color_comment red
# set -g fish_color_cwd green
# set -g fish_color_cwd_root red
# set -g fish_color_error red
# set -g fish_color_escape cyan
# set -g fish_color_history_current cyan
# set -g fish_color_match cyan
# set -g fish_color_normal normal
# set -g fish_color_operator cyan
# set -g fish_color_param cyan
# set -g fish_color_quote brown
# set -g fish_color_redirection normal
# set -g fish_color_search_match --background purple
# set -g fish_color_valid_path --underline
# set -g fish_pager_color_completion normal
# set -g fish_pager_color_description yellow
# set -g fish_pager_color_prefic cyan
# set -g fish_pager_color_progress cyan

