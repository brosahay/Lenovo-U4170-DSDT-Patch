#!/bin/sh

#  patch_power.sh
#  u4170
#
#  Created by Rohan Sahay on 19/03/17.
#  Copyright © 2017 revosftw. All rights reserved.

echo "Downloading SSDT for Power Management"
curl --fail -o ./ssdtPRGen.sh https://raw.githubusercontent.com/Piker-Alpha/ssdtPRGen.sh/master/ssdtPRGen.sh
echo "Changing permission of the SSDT Script"
chmod +x ./ssdtPRGen.sh
echo "Generating SSDT for Power Management"
./ssdtPRGen.sh
echo "Patching up CLOVER"
cp ~/Library/ssdtPRGen/ssdt.aml /Volumes/EFI/EFI/Clover/ACPI/patched/SSDT.aml
echo "Disabling Sleep or Suspend"
sudo pmset -a hibernatemode 0
sudo rm /var/vm/sleepimage
sudo mkdir /var/vm/sleepimage
echo "Finished Patching Power Management"
