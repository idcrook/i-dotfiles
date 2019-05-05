#! /usr/bin/osascript  ## -*- apples -*-

set mountedDiskName to "Music"
set diskIsMounted to false

tell application "System Events" to set diskNames to name of every disk

if mountedDiskName is in diskNames then

	set diskIsMounted to true
	log quoted form of mountedDiskName & " is already mounted. skipping..."

else

	log "Mounting disk " & mountedDiskName
	tell application "Finder"
		mount volume "smb://dpc@N5550/Music"
	end tell


end if

# //dpc@N5550/Music on /Volumes/Music (smbfs, nodev, nosuid, mounted by dpc)
