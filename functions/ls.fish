#
# Make ls use colors if we are on a system that supports this
#

if command ls --version 1>/dev/null 2>/dev/null
	# This is GNU ls
	function ls --description "List contents of directory"
		set -l param --color=auto
		if isatty 1
			set param $param --indicator-style=classify
		end
		command ls $param $argv
	end

  # TODO: Enable this once you have a terminal that supports true colors.
  # if type -f gdircolors >/dev/null
	# 	eval (gdircolors -c ~/.config/dircolors/tomorrow-night-bright)
	# end
  setenv LSCOLORS gxBxhxDxfxhxhxhxhxcxcx

else
	# BSD, OS X and a few more support colors through the -G switch instead
	if command ls -G / 1>/dev/null 2>/dev/null
		function ls --description "List contents of directory"
			command ls -G $argv
		end
	end
end
