function words --description "count words in markdown files in the current directory (recursively)."
	echo (wc **/*.md *.md -w | tail -n 1 | tr -d ' total')
end
