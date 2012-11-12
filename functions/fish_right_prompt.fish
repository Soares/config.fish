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

function fish_right_prompt
	echo -n $__prompt_fg_weekday(date +"%a")' '
	echo -n $__prompt_fg_daynum(date +"%d")' '
	echo -n $__prompt_reset
	echo -n $__prompt_fg_time(date +"%H:%M")' '
	__prompt_battery_info
	echo -n $__prompt_reset
end
