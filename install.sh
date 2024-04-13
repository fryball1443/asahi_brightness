#!/bin/bash
backlight_file=/sys/class/backlight/apple-panel-bl/brightness
max_backlight_file=/sys/class/backlight/apple-panel-bl/max_brightness
keybacklight_file=/sys/devices/platform/led-controller/leds/kbd_backlight/brightness
max_keybacklight_file=/sys/devices/platform/led-controller/leds/kbd_backlight/max_brightness
default_backlight_file=~/bin/asahi_brightness/packages/default_screen_brightness
default_keybacklight_file=~/bin/asahi_brightness/packages/default_keyboard_brightness
help_file=~/asahi_brightness/packages/helpfile

sudo chmod a+rw $backlight_file
sudo chmod a+rw $keybacklight_file
sudo chmod a+r $max_backlight_file
sudo chmod a+r $max_keybacklight_file
sudo chmod a+rw $default_backlight_file
sudo chmod a+rw $default_keybacklight_file
sudo chmod a+r $help_file

cd ~/asahi_brightness
echo "git log:"
git pull
echo ""

if [ ! -d ~/bin ]; then
  mkdir ~/bin
  echo "created ~/bin folder"
elif [ ! -d ~/bin/asahi_brightness ]; then
  mkdir ~/bin/asahi_brightness
  echo "created ~/bin/asahi_brightness folder"
elif [ ! -d ~/bin/asahi_brightness/packages ]; then
  mkdir ~/bin/asahi_brightness
  mkdir ~/bin/asahi_brightness/packages
  echo "created ~/bin/asahi_brightness folder"
fi

echo "enter desired "default" brightness % for screen 
      or 'skip' to skip this step
      or 'default' to 150 nits"
read screen_brightness
echo "enter desired "default" brightness % for keyboard
      or 'skip' to skip this step
      or 'default' to 3 nits"
read keyboard_brightness

#if (screen_brightness || keyboard_brightness) != "skip"; then
#  echo "$screen_brightness" > ~/asahi_brightness/default_screen_brightness
#  echo "$keyboard_brightness" > ~/asahi_brightness/default_keyboard_brightness
#else 
#  echo "150" > ~/asahi_brightness/default_screen_brightness
#  echo "3" > ~/asahi_brightness/default_keyboard_brightness
#fi
if [[ $screen_brightness == "skip" || $keyboard_brightness == "skip" ]]; then
  if [ ! -f $default_backlight_file ]; then
    echo "150" > $default_backlight_file
  fi
  if [ ! -f $default_keybacklight_file ]; then
    echo "3" > $default_keybacklight_file
  fi
fi

if [[ $screen_brightness == "default" && $keyboard_brightness == "default" ]]; then
  echo "150" > $default_backlight_file
  echo "3" > $default_keybacklight_file
elif [[ $screen_brightness == "default" && $keyboard_brightness == "skip" ]]; then
  echo "150" > $default_backlight_file
elif [[ $screen_brightness == "skip" && $keyboard_brightness == "default" ]]; then
  echo "3" > $default_keybacklight_file
elif [[ $screen_brightness == "skip" && $keyboard_brightness == "skip" ]]; then
  echo "skipped setting default brightness"
elif [[ $screen_brightness != "skip" && $screen_brightness != "default" && $keyboard_brightness == "skip" ]]; then
  echo "$screen_brightness" > $default_backlight_file
elif [[ $screen_brightness == "skip" && $keyboard_brightness != "skip" && $keyboard_brightness != "default" ]]; then
  echo "$keyboard_brightness" > $default_keybacklight_file
else
  echo "$screen_brightness" > $default_backlight_file
  echo "$keyboard_brightness" > $default_keybacklight_file
fi

#cat ./change_brightness.sh >> ~/bin/change_brightness.sh
if cmp -s ~/asahi_brightness/packages/change_brightness.sh ~/bin/change_brightness.sh; then
  echo "change_brightness.sh is already up to date."
else
  cat ~/asahi_brightness/packages/change_brightness.sh > ~/bin/change_brightness.sh
  echo "updated change_brightness.sh."
fi

if [ -f ~/.zshrc ]; then
  if ! grep -q "alias chbr='bash ~/bin/change_brightness.sh'" ~/.zshrc; then
    echo ""                                                  >> ~/.zshrc
    echo "# alias to change brightness in asahi_m1"          >> ~/.zshrc
    echo "alias chbr='bash ~/bin/change_brightness.sh'" >> ~/.zshrc
    
    echo "added alias to .zshrc"
  else
    echo ".zshrc already contains required alias. skipping."
  fi
else
  echo ".zshrc doesn't exist. Only outputting to .basrc"
fi


if [ -f ~/.bashrc ]; then
  if ! grep -q "alias chbr='bash ~/bin/change_brightness.sh'" ~/.bashrc; then
    echo ""                                                  >> ~/.zshrc
    echo "# alias to change brightness in asahi_m1"          >> ~/.bashrc
    echo "alias chbr='bash ~/bin/change_brightness.sh'" >> ~/.bashrc
    
    echo "added alias to .bashrc"
  else
    echo ".bashrc already contains required alias. skipping."
  fi
fi

echo "installation complete."
echo ""
sleep 1

cat ./README.md