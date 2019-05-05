#! /usr/bin/osascript  ## -*- apples -*-

set mountedDiskName to "Multimedia"
set diskIsMounted to false

tell application "System Events" to set diskNames to name of every disk

if mountedDiskName is in diskNames then

	set diskIsMounted to true
	log quoted form of mountedDiskName & " is already mounted. skipping..."

else

	log "Mounting disk " & mountedDiskName
	tell application "Finder"
		mount volume "smb://admin@10.0.1.13/Multimedia"
	end tell


end if

# //admin@10.0.1.13/Multimedia  on /Volumes/Multimedia (smbfs, nodev, nosuid, mounted by dpc)
