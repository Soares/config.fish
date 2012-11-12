# Bugs:
#  the __prompt_statuschar else if bug. WTF!?
#  default keybindings erase all other bindings
#  same with default commands
#  can't multiline in (parens)
set fish_greeting ''

set -g __prompt_fg_sep (set_color cyan)
set -g __prompt_fg_mux (set_color blue)
set -g __prompt_fg_user (set_color magenta)
set -g __prompt_fg_at (set_color white)
set -g __prompt_fg_host (set_color yellow)
set -g __prompt_fg_path (set_color green)
set -g __prompt_fg_branch (set_color magenta)
set -g __prompt_fg_weekday (set_color magenta)
set -g __prompt_fg_daynum (set_color -o magenta)
set -g __prompt_fg_month (set_color normal)
set -g __prompt_fg_time (set_color green)
set -g __prompt_fg_charging (set_color blue)
set -g __prompt_fg_prompt (set_color cyan)
set -g __prompt_fg_good (set_color green)
set -g __prompt_fg_warning (set_color yellow)
set -g __prompt_fg_bad (set_color red)
set -g __prompt_fg_urgent (set_color -o white)
set -g __prompt_bg_urgent (set_color -b red)
set -g __prompt_reset (set_color normal)
set -g __prompt_host (hostname|cut -d . -f 1)


function __prompt_tmux
	if test $TERM != tmux; return; end
	set session (tmux display-message -p "#S")
	if test $session != 0
		echo -n $__prompt_fg_mux$session$__prompt_fg_sep'|'
	end
	echo -n $__prompt_fg_mux(tmux display-message -p "#I")$__prompt_fg_sep'.'
end

function __prompt_whereami
	# Todo: Collapse this as it gets too long.
	set -l dir (pwd | sed -e "s,^$HOME,~,")
	set -l path (echo $dir | tr '/' '\n')
	set -l len (count $path)
	set -l collapse (expr $len - 3)
	echo -n $path[1]
	if test $len -eq 1
		return
	end
	if test $collapse -gt 1
		for elem in $path[2..$collapse]
			echo -n /
		end
	else
		set collapse 1
	end
	for elem in $path[(expr $collapse + 1)..$len]
		echo -n /$elem
	end
end

function __prompt_battery_info
	set -l charge (acpi -b | sed 's/.*, \([0-9]\+\).*/\1/')
	if test $charge -ge 98
		return
	else if test (expr (acpi -b) : '.*Discharging') -eq 0
		echo -n $__prompt_fg_charging
	else if test $charge -ge 70
		echo -n $__prompt_fg_good
	else if test $charge -ge 30
		echo -n $__prompt_fg_warning
	else if test $charge -ge 12
		echo -n $__prompt_fg_bad
	else
		echo -n $__prompt_fg_urgent
		echo -n $__prompt_bg_urgent
	end
	echo -n [$charge%]$__prompt_reset
end

function __prompt_git_location
	set -l branch (git symbolic-ref HEAD ^/dev/null|cut -d '/' -f 3)
	set -l tag (git describe --tags --exact-match HEAD ^/dev/null)
	if test -z "$branch$tag"
		echo -n $__prompt_fg_branch' <detached> '
		return
	end
	echo -n $__prompt_fg_sep' on '
	test -n "$branch"; and echo -n $__prompt_fg_branch$branch
	test -n "$tag"; and echo -n $__prompt_fg_sep'#'$__prompt_fg_branch$tag;
	echo -n ' '
end

function __prompt_statuschar
	expr index $__prompt_gs_staged $argv[1] >/dev/null ^&1
	and echo -n $__prompt_reset$argv[2]
	expr index $__prompt_gs_indexed $argv[1] >/dev/null ^&1
	and echo -n $__prompt_fg_branch$argv[2]
end

function __prompt_git_status
	set -l gs (git status --porcelain ^/dev/null|cut -c 1-2|sort|tr -d '\n')

	# Exist if everything is hunky dory
	test -z $gs; and echo -n $__prompt_fg_good'✔'; and return 0

	# Check if there are unmerged or unstaged files
	echo $gs|grep -qe "^\(..\)*\(UU\|MM\|AA\)"; and set unmerged
	echo $gs|grep -qe "^\(..\)*??"; and set unstaged

	# Split up the index flags and the staging flags
	set -g __prompt_gs_indexed (echo $gs|sed -e "s/\(.\).\?/\1/g"|tr -d '?U')
	set -g __prompt_gs_staged (echo $gs|sed -e "s/.\(.\?\)/\1/g"|tr -d '?U')

	__prompt_statuschar 'M' '*'
	__prompt_statuschar 'A' '+'
	__prompt_statuschar 'R' '→'
	__prompt_statuschar 'C' '⇒'
	__prompt_statuschar 'D' '✗'

	set -e __prompt_gs_indexed
	set -e __prompt_gs_staged
	set -q unstaged; and echo -n $__prompt_fg_warning'?'
	set -q unmerged; and echo -n $__prompt_fg_bad'!'
	return 0
end

function fish_prompt
	set laststatus $status
	# Stick in some multiplexor state
	__prompt_tmux
	# Username
	echo -n $__prompt_fg_user(whoami)$__prompt_fg_at'@'
	# Host
	echo -n $__prompt_fg_host$__prompt_host$__prompt_fg_sep':'
	# Location
	echo -n $__prompt_fg_path(__prompt_whereami)
	# Become aware of the repository
	set -l gitdir (git rev-parse --git-dir ^/dev/null)
	test -n "$gitdir";
	and __prompt_git_location
	# Consider __prompt_git_upstream here when you know what you're doing
	and __prompt_git_status
	# Multi-lineification & status color
	test $laststatus -ne 0
	and echo $__prompt_fg_bad
	or echo $__prompt_fg_prompt
	# Repository aware prompt character
	test -n "$gitdir"; and echo -n »; or echo -n →
	# Prep for user input
	echo -n $__prompt_reset' '
end

function fish_right_prompt
	echo -n $__prompt_fg_weekday(date +"%a")' '
	echo -n $__prompt_fg_daynum(date +"%d")' '
	echo -n $__prompt_reset
	echo -n $__prompt_fg_time(date +"%H:%M")' '
	__prompt_battery_info
	echo -n $__prompt_reset
end
