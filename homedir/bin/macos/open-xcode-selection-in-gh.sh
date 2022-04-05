#!/bin/bash
# https://gist.github.com/alexpersian/f3cdba10cb17727235c448e8a4788545

# Credit to Joel Ekström at Spotify for original creation.

# USAGE:
# 1. Replace `{ insert repo url here }` at the bottom with your GH repo's URL
# 2. `chmod +x open-xcode-selection-in-gh.sh` to make it executable
# 3. Create a new Behaviour in Xcode settings. In the bottom, select "Run script", and choose this file
# 4. Next to your new behaviour in the list, click the cmd symbol to add to keyboard shortcut

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
IFS=, read -r file_path selection_start selection_end <<< "$file_and_selection"; unset IFS;

# Trim quotation marks
file_path=$(echo $file_path | sed "s/\"//g")

# Get relative location of file by cd'ing to the folder and checking the git root and removing that prefix
cd $(dirname $file_path)
project_root=$(git rev-parse --show-toplevel)
relative_path=${file_path#"$project_root"}

# Figure out the line numbers of the start/end of selection
str=$(cat $file_path)
selection_end=${selection_end:-'1'}
text_to_selection_start=${str:0:$selection_start}
text_to_selection_end=${str:0:$selection_end}
lineno_at_start=$(echo "$text_to_selection_start" | wc -l)
lineno_at_end=$(echo "$text_to_selection_end" | wc -l)

# Trim whitespace
lineno_at_start=$(echo $lineno_at_start | xargs)
lineno_at_end=$(echo $lineno_at_end | xargs)

open "{ insert repo url here }/$relative_path#L$lineno_at_start-L$lineno_at_end"
