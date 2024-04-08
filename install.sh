#!/bin/bash
echo "git log:"
git pull
echo ""

if [ ! -d ~/bin ]; then
  mkdir ~/bin
  echo "created ~/bin folder"
fi

#cat ./change_brightness.sh >> ~/bin/change_brightness.sh
if cmp -s ./change_brightness.sh ~/bin/change_brightness.sh; then
  echo "change_brightness.sh is already up to date."
else
  cat ./change_brightness.sh > ~/bin/change_brightness.sh
  echo "updated change_brightness.sh."
fi

if [ -f ~/.zshrc ]; then
  if ! grep -q "alias chbr='sudo bash ~/bin/change_brightness.sh'" ~/.zshrc; then
    echo ""                                                  >> ~/.zshrc
    echo "# alias to change brightness in asahi_m1"          >> ~/.zshrc
    echo "alias chbr='sudo bash ~/bin/change_brightness.sh'" >> ~/.zshrc
    echo "added alias to .zshrc"
  else
    echo ".zshrc already contains required alias. skipping."
  fi
else
  echo ".zshrc doesn't exist. Only outputting to .basrc"
fi


if [ -f ~/.bashrc ]; then
  if ! grep -q "alias chbr='sudo bash ~/bin/change_brightness.sh'" ~/.bashrc; then
    echo ""                                                  >> ~/.zshrc
    echo "# alias to change brightness in asahi_m1"          >> ~/.bashrc
    echo "alias chbr='sudo bash ~/bin/change_brightness.sh'" >> ~/.bashrc
    echo "added alias to .bashrc"
  else
    echo ".bashrc already contains required alias. skipping."
  fi
fi

echo "done"