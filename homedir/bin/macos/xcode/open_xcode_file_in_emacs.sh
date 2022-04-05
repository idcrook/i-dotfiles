#!/bin/bash

# https://gist.github.com/joelekstrom/600427d62ff13d294923258c4041f5fe

# Use AppleScript to get the open file and selection from Xcode
file_and_selection=$(osascript\
<<EOF
tell application "Xcode"
	set current_document to document 1 whose name ends with (word -1 of (get name of window 1))
	set current_document_path to path of current_document
	set selected_range to selected character range of current_document
	set selection_start to first item of selected_range
	set selection_end to second item of selected_range
end tell

return "\"" & current_document_path & "\"," & selection_start & "," & selection_end
EOF
)
IFS=, read -r file selection_start selection_end <<< "$file_and_selection"
file="$file"

# Open file and set point (and region if needed) in Emacs
/usr/local/bin/emacsclient -e "
(progn
  (find-file ${file})
  (goto-char ${selection_start})
  (unless (< ${selection_end} ${selection_start})
     (push-mark ${selection_start})
     (goto-char (1+ ${selection_end}))
     (activate-mark)))"

# Bring Emacs to front
osascript -e 'tell application "Emacs" to activate'
