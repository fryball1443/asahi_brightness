import tkinter as tk
from tkinter import messagebox
from tkinter import Scale, HORIZONTAL
import os
import subprocess

# file locations
backlight_file="/sys/class/backlight/apple-panel-bl/brightness"
max_backlight_file="/sys/class/backlight/apple-panel-bl/max_brightness"
keybacklight_file="/sys/devices/platform/led-controller/leds/kbd_backlight/brightness"
max_keybacklight_file="/sys/devices/platform/led-controller/leds/kbd_backlight/max_brightness"

def get_max_brightness(file):
    with open(file, 'r') as f:
        return int(f.read().strip())

def get_current_brightness(file):
    with open(file, 'r') as f:
        return int(f.read().strip())

def set_brightness(file, value):
    cmd = f'echo {value} | sudo tee {file}'
    subprocess.call(cmd, shell=True)

def apply_changes():
    set_brightness(backlight_file, scale_screen.get())
    set_brightness(keybacklight_file, scale_keyboard.get())

def revert_changes():
    scale_screen.set(get_current_brightness(backlight_file))
    scale_keyboard.set(get_current_brightness(keybacklight_file))

def exit_program():
    revert_changes()
    root.quit()

root = tk.Tk()
root.title("Brightness Control")

scale_screen = Scale(root, from_=0, to=get_max_brightness(max_backlight_file), orient=HORIZONTAL)
scale_screen.set(get_current_brightness(backlight_file))
scale_screen.pack()

scale_keyboard = Scale(root, from_=0, to=get_max_brightness(max_keybacklight_file), orient=HORIZONTAL)
scale_keyboard.set(get_current_brightness(keybacklight_file))
scale_keyboard.pack()

btn_apply = tk.Button(root, text="Apply", command=apply_changes)
btn_apply.pack()

btn_ok = tk.Button(root, text="OK", command=root.quit)
btn_ok.pack()

btn_revert = tk.Button(root, text="Revert", command=revert_changes)
btn_revert.pack()

btn_cancel = tk.Button(root, text="Cancel", command=exit_program)
btn_cancel.pack()

root.mainloop()
