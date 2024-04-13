#!/bin/bash

# This script is used to change the brightness of the screen and keyboard
# brightness on the M1 Macs. It takes two arguments, a flag and a percentage
# value. The flag determines which brightness to change, and the percentage
# value determines how much to change it by. The flags are as follows:
# -s: change the screen brightness
# -k: change the keyboard brightness
# -ks: change both the screen and keyboard brightness
# -sk: change both the screen and keyboard brightness
# -d: set the brightness to the default values
# --help, -h: display the help page


# file locations
backlight_file=/sys/class/backlight/apple-panel-bl/brightness
max_backlight_file=/sys/class/backlight/apple-panel-bl/max_brightness
keybacklight_file=/sys/devices/platform/led-controller/leds/kbd_backlight/brightness
max_keybacklight_file=/sys/devices/platform/led-controller/leds/kbd_backlight/max_brightness
default_backlight_file=~/bin/asahi_brightness/packages/default_screen_brightness
default_keybacklight_file=~/bin/asahi_brightness/packages/default_keyboard_brightness
help_file=~/asahi_brightness/packages/helpfile


# Calculate converts the number you gave as a % out of the total brightness
# Parse a whole number from the calculation
# echo the value(nits) to the brightness file
case $1 in
  # for if you want to adjust just the screen brightness
    -s)
        if [ -z "$1" ] || [ -z "$2" ]
        then
            echo "Please provide a flag (-s or -k) and a percentage value. Type chbr --help for more info."
            exit 1
        fi
        max_brightness=$(cat $max_backlight_file)
        result=$(echo "scale=1; $2 / 100 * $max_brightness" | bc)
        result=$(echo $result | awk -F. '{print $1}')
        sudo echo $result > $backlight_file
        ;;
  # for if you want to adjust keyboard brightness
    -k)
        if [ -z "$1" ] || [ -z "$2" ]
        then
            echo "Please provide a flag (-s or -k) and a percentage value. Type chbr --help for more info."
            exit 1
        fi
        max_brightness=$(cat $max_keybacklight_file)
        result=$(echo "scale=1; $2 / 100 * $max_brightness" | bc)
        result=$(echo $result | awk -F. '{print $1}')
        sudo echo $result > $keybacklight_file
        ;;
  # for if you want to adjust both the keyboard brightness and screen brightness
    -ks)
        if [ -z "$1" ] || [ -z "$2" ]
        then
            echo "Please provide a flag (-s or -k) and a percentage value. Type chbr --help for more info."
            exit 1
        fi
        max_brightness=$(cat $max_backlight_file)
        result=$(echo "scale=1; $2 / 100 * $max_brightness" | bc)
        result=$(echo $result | awk -F. '{print $1}')
        sudo echo $result > $backlight_file
        max_brightness=$(cat $max_keybacklight_file)
        result=$(echo "scale=1; $2 / 100 * $max_brightness" | bc)
        result=$(echo $result | awk -F. '{print $1}')
        sudo echo $result > $keybacklight_file
        ;;
    -sk)
        if [ -z "$1" ] || [ -z "$2" ]
        then
            echo "Please provide a flag (-s or -k) and a percentage value. Type chbr --help for more info."
            exit 1
        fi
        max_brightness=$(cat $max_backlight_file)
        result=$(echo "scale=1; $2 / 100 * $max_brightness" | bc)
        result=$(echo $result | awk -F. '{print $1}')
        sudo echo $result > $backlight_file
        max_brightness=$(cat $max_keybacklight_file)
        result=$(echo "scale=1; $2 / 100 * $max_brightness" | bc)
        result=$(echo $result | awk -F. '{print $1}')
        sudo echo $result > $keybacklight_file
        ;;
    # default brightness
    -d)
        screen_brightness=$(cat $default_backlight_file)
        keyboard_brightness=$(cat $default_keybacklight_file)
        sudo echo $screen_brightness > $backlight_file
        sudo echo $keyboard_brightness > $keybacklight_file
        ;;
    # display the help page
    --help)
        cat $help_file
        ;;
    -h)
        cat $help_file
        ;;
    *)
        echo "Please provide a flag and a percentage value. Type chbr --help for more info."
        exit 1
        ;;
esac