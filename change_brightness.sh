#!/bin/bash

# Check if argument is provided
if [ -z "$1" ] || [ -z "$2" ]
then
    echo "Please provide a flag (-s or -k) and a percentage value."
    exit 1
fi

# file locations
backlight_file=/sys/class/backlight/apple-panel-bl/brightness
max_backlight_file=/sys/class/backlight/apple-panel-bl/max_brightness
keybacklight_file=/sys/devices/platform/led-controller/leds/kbd_backlight/brightness
max_keybacklight_file=/sys/devices/platform/led-controller/leds/kbd_backlight/max_brightness

# Calculate converts the number you gave as a % out of the total brightness
# Parse a whole number from the calculation
# echo the value(nits) to the brightness file
case $1 in
  # for if you want to adjust just the screen brightness
    -s)
        max_brightness=$(cat $max_backlight_file)
        result=$(echo "scale=1; $2 / 100 * $max_brightness" | bc)
        result=$(echo $result | awk -F. '{print $1}')
        sudo echo $result > $backlight_file
        ;;
  # for if you want to adjust keyboard brightness
    -k)
        max_brightness=$(cat $max_keybacklight_file)
        result=$(echo "scale=1; $2 / 100 * $max_brightness" | bc)
        result=$(echo $result | awk -F. '{print $1}')
        sudo echo $result > $keybacklight_file
        ;;
  # for if you want to adjust both the keyboard brightness and screen brightness
    -ks)
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
        max_brightness=$(cat $max_backlight_file)
        result=$(echo "scale=1; $2 / 100 * $max_brightness" | bc)
        result=$(echo $result | awk -F. '{print $1}')
        sudo echo $result > $backlight_file
        max_brightness=$(cat $max_keybacklight_file)
        result=$(echo "scale=1; $2 / 100 * $max_brightness" | bc)
        result=$(echo $result | awk -F. '{print $1}')
        sudo echo $result > $keybacklight_file
        ;;
    *)
        echo "Invalid flag. Use -s for screen brightness or -k for keyboard brightness."
        exit 1
        ;;
esac