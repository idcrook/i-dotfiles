#! /usr/bin/osascript  ## -*- apples -*-

set mountedDiskName to "Documents"
set diskIsMounted to false

tell application "System Events" to set diskNames to name of every disk

if mountedDiskName is in diskNames then

	set diskIsMounted to true
	log quoted form of mountedDiskName & " is already mounted. skipping..."

else

	log "Mounting disk " & mountedDiskName
	tell application "Finder"
		mount volume "smb://dpc@10.0.1.13/Documents"
	end tell


end if

# //dpc@10.0.1.13/Documents on /Volumes/Documents (smbfs, nodev, nosuid, mounted by dpc)
