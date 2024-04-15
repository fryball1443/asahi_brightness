# Asahi Linux Brightness Changer
### Nolen Jensen (fryball1443)
Simple script to update the brightness in Asahi Linux Apple silicon project.
If you have any problems with this script, message me @fryball:beeper.com

Disclaimer:
this was built on Asahi Ubuntu, so it might require tweaking for other versions of Asahi.
If you need help with another version, I can't promise I can help, but feel free to message me @fryball:beeper.com

Credits:
This was created based on instructions from https://www.reddit.com/r/AsahiLinux/comments/11k109p/comment/jbig1u6/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button


## changelog:
Version 1.1

changelog:
- reorganized file structure and added default settings that are customizable when running the install.sh

Added:
- New flags -d, --help, and -h to the chbr script.
- -d flag in chbr script sets the brightness to the default values.
- --help and -h flags in chbr script display the help page.
- New file locations default_backlight_file, default_keybacklight_file, and help_file in chbr script.
- Checks for arguments in each case of the switch statement in chbr script.
- Variables for file paths to improve readability and maintainability.
- Commands to change permissions of several files to make them readable and writable.
- Checks and commands to create new directories if they do not exist.
- User prompts to enter desired default brightness for screen and keyboard.
- Conditions to handle user input for default brightness settings.

Changed:
- Moved the check for arguments from the start of the script to each case in the switch statement in chbr script.
- Updated the error messages in chbr script to include a suggestion to type chbr --help for more info.
- Updated the comparison and copying of `change_brightness.sh` to use the new file path.
- Updated the final echo statements to indicate the completion of installation and provide a help command.

Removed:
- The initial check for arguments at the start of the chbr script.
- `sudo` from the alias command in `.zshrc` and `.bashrc` files.

## Instructions
git clone to user_home folder (~/)

to install, type cd ~user//install.sh

to use:
- run installation script
- command to change brightness: chbr

### Syntax:
Usage: chbr [OPTION]... [PERCENTAGE]...  
Note: -s and -k and be used together  
 Options:  
	-s [percentage]  set the screen brightness to the specified percentage  
 -k [percentage]  set the keyboard brightness to the specified percentage  
 -d               set keyboard and screen to their default values  
 -h, --help       display this help message and exit  

Examples:  
  chbr -s 30       change screen brightness to 30%  
  chbr -k 30       change keyboard brightness to 30%  
  chbr -d          change brightness to default values  
  chbr -sk 23      change both the keyboard and screen brightness to 23%  
