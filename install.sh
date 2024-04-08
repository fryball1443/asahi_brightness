#!/bin/bash
echo "git log:"
git pull
echo ""
if ! dpkg -s python3-tk >/dev/null 2>&1; then
  read -p "Tkinter is not installed. Do you want to install it? (y/n): " choice
  if [ "$choice" == "y" ]; then
    sudo apt-get install python3-tk
  else
    echo "Installation cancelled. Exiting..."
    exit 1
  fi
fi

if [ ! -d ~/bin ]; then
  mkdir ~/bin
  echo "created ~/bin folder"
fi
 
#cat ./change_brightness.pyw >> ~/bin/change_brightness.pyw
if cmp -s ./change_brightness.pyw ~/bin/change_brightness.pyw; then
  echo "change_brightness.pyw is already up to date."
else
  cat ./change_brightness.pyw > ~/bin/change_brightness.pyw
  echo "updated change_brightness.pyw."
fi

if [ -f ~/.zshrc ]; then
  if ! grep -q "alias brightness='sudo python3 ~/bin/change_brightness.pyw'" ~/.zshrc; then
    echo ""                                                         >> ~/.zshrc
    echo "# alias to change brightness in asahi_m1"                 >> ~/.zshrc
    echo "alias brightness='sudo python3 ~/bin/change_brightness.pyw'" >> ~/.zshrc
    echo "added alias to .zshrc"
  else
    echo ".zshrc already contains required alias. skipping."
  fi
else
  echo ".zshrc doesn't exist. Only outputting to .basrc"
fi


if [ -f ~/.bashrc ]; then
  if ! grep -q "alias brightness='sudo python3 ~/bin/change_brightness.pyw'" ~/.bashrc; then
    echo ""                                                         >> ~/.zshrc
    echo "# alias to change brightness in asahi_m1"                 >> ~/.bashrc
    echo "alias brightness='sudo python3 ~/bin/change_brightness.pyw'" >> ~/.bashrc
    echo "added alias to .bashrc"
  else
    echo ".bashrc already contains required alias. skipping."
  fi
fi

echo "done"