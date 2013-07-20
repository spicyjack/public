# OS X Directory Services #

## Add a group through the GUI ##
- System Preferences
- Users & Groups
- Click on the `+` symbol on the lower left hand corner of the window
- Authenticate if required
- For `New:`, use the dropdown to choose `Group`
- Enter the name of the new group in the `Full Name:` textbox
- Press `Create Group` to create the group
- If you need to rename the group or give the group a custom group ID (GID),
  `Ctrl-Click`/right click on the new group and choose `Advanced Options`

## List and read a group through the CLI ##
- Use `dscl . -list` to list groups on the local machine
  - Forward-slashes in the directory path need to be escaped
    - Example: `/Mounts/ldaphost:\/Users`
  - List all directory nodes from the root: `dscl . -list /`
  - List all groups: `dscl . -list /Groups`
  - List all users: `dscl . -list /Users`
- List all groups on the machine, sorted by GID
  - `dscl . -list /Groups PrimaryGroupID | sort -n -k 2`

## Create groups through the CLI ##
- `sudo dscl . -create /Groups/foo`
- `sudo dscl . -create /Groups/foo PrimaryGroupID 1234`

## For more help ##
- `man DirectoryService`
- `man DirectoryServiceAttributes` - standard attributes in `DirectoryService`
- `man dscl` - Directory Service command line utility
- `man odutil` - examine or change the state of `opendirectoryd`
- `man opendirectory` - Describes `opendirectoryd` the replacement for
  `DirectorySerivce`
- `man id` - information about user/group IDs

## Links ##
- http://jamesmead.org/blog/2011-01-20-adding-a-user-in-osx-on-command-line
vim: filetype=markdown shiftwidth=2 tabstop=2
