#!/bin/bash

echo "Uninstalling VoodooHDA"

sudo rm -r /System/Library/Extensions/AppleHDADisabler.kext*
sudo rm -r /System/Library/Extensions/VoodooHDA.kext*
echo "VoodooHDA kexts removed "

echo "Removing Preference Pane..."
sudo rm -r /System/Library/PreferencePanes/VoodooHDA.prefPane*

echo "Removing from applications..."
sudo rm -r /Applications/VoodooHdaSettingsLoader.app*

