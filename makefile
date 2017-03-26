# makefile

#
# Patches/Installs/Builds DSDT patches for Lenovo u4170
#
# Created by RehabMan
# Modified by Revosftw
#

BUILDDIR=./build
HDA=ALC235
RESOURCES=./Resources_$(HDA)
HDAINJECT=AppleHDA_$(HDA).kext
HDAHCDINJECT=AppleHDAHCD_$(HDA).kext
HDAZML=AppleHDA_$(HDA)_Resources
#USBINJECT=USBXHC_u430.kext
#BACKLIGHTINJECT=AppleBacklightInjector.kext

VERSION_ERA=$(shell ./print_version.sh)
ifeq "$(VERSION_ERA)" "10.10-"
    INSTDIR=/System/Library/Extensions
else
    INSTDIR=/Library/Extensions
endif
SLE=/System/Library/Extensions

# set build products
PRODUCTS=$(BUILDDIR)/SSDT-HACK.aml $(BUILDDIR)/SSDT-ALC235.aml

IASLFLAGS=-vw 2095 -vw 2146
IASL=iasl

.PHONY: all
all: $(PRODUCTS) $(HDAHCDINJECT) #  $(HDAINJECT)
$(BUILDDIR)/SSDT-EH01.aml: ./patched_dsdt/SSDT-EH01.dsl
    $(IASL) $(IASLFLAGS) -p $@ $<

$(BUILDDIR)/SSDT-EH02.aml: ./patched_dsdt/SSDT-EH02.dsl
    $(IASL) $(IASLFLAGS) -p $@ $<

$(BUILDDIR)/SSDT-HDAU.aml: ./patched_dsdt/SSDT-HDAU.dsl
    $(IASL) $(IASLFLAGS) -p $@ $<

$(BUILDDIR)/SSDT-IGPU.aml: ./patched_dsdt/SSDT-IGPU.dsl
    $(IASL) $(IASLFLAGS) -p $@ $<

$(BUILDDIR)/SSDT-LPC.aml: ./patched_dsdt/SSDT-LPC.dsl
    $(IASL) $(IASLFLAGS) -p $@ $<

$(BUILDDIR)/SSDT-SATA.aml: ./patched_dsdt/SSDT-SATA.dsl
    $(IASL) $(IASLFLAGS) -p $@ $<

$(BUILDDIR)/SSDT-XOSI.aml: ./patched_dsdt/SSDT-XOSI.dsl
    $(IASL) $(IASLFLAGS) -p $@ $<

$(BUILDDIR)/SSDT-ALC235.aml: ./SSDT-ALC235.dsl
    $(IASL) $(IASLFLAGS) -p $@ $<

.PHONY: clean
clean:
    rm -f $(BUILDDIR)/*.dsl $(BUILDDIR)/*.aml
    make clean_hda

# Clover Install
.PHONY: install
install: $(PRODUCTS)
    $(eval EFIDIR:=$(shell sudo ./mount_efi.sh /))
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-EH01.aml
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-EH02.aml
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-HDAU.aml
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-IGPU.aml
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-LPC.aml
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-SATA.aml
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-XOSI.aml
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-ALC235.aml
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/DSDT.aml
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-2.aml
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-3.aml
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-4.aml
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-5.aml
    rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-7.aml
    cp $(BUILDDIR)/SSDT-EH01.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-EH01.aml
    cp $(BUILDDIR)/SSDT-EH02.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-EH02.aml
    cp $(BUILDDIR)/SSDT-HDAU.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-HDAU.aml
    cp $(BUILDDIR)/SSDT-IGPU.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-IGPU.aml
    cp $(BUILDDIR)/SSDT-LPC.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-LPC.aml
    cp $(BUILDDIR)/SSDT-SATA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-SATA.aml
    cp $(BUILDDIR)/SSDT-XOSI.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-XOSI.aml
    cp $(BUILDDIR)/SSDT-ALC235.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-ALC235.aml

#$(HDAINJECT) $(HDAHCDINJECT): $(RESOURCES)/*.plist ./patch_hda.sh
$(HDAHCDINJECT): $(RESOURCES)/*.plist ./patch_hda.sh
    ./patch_hda.sh $(HDA)

.PHONY: clean_hda
clean_hda:
    rm -rf $(HDAHCDINJECT) $(HDAZML) # $(HDAINJECT)

$(BACKLIGHTINJECT): Backlight.plist patch_backlight.sh
    ./patch_backlight.sh
    touch $@

.PHONY: update_kernelcache
    update_kernelcache:
    sudo touch $(SLE)
    sudo kextcache -update-volume /

.PHONY: install_hdadummy
install_hdadummy:
    sudo rm -Rf $(INSTDIR)/$(HDAINJECT)
    sudo rm -Rf $(INSTDIR)/$(HDAHCDINJECT)
    sudo cp -R ./$(HDAINJECT) $(INSTDIR)
    sudo rm -f $(SLE)/AppleHDA.kext/Contents/Resources/*.zml*
    if [ "`which tag`" != "" ]; then sudo tag -a Blue $(INSTDIR)/$(HDAINJECT); fi
    make update_kernelcache

.PHONY: install_hda
install_hda:
    sudo rm -Rf $(INSTDIR)/$(HDAINJECT)
    sudo rm -Rf $(INSTDIR)/$(HDAHCDINJECT)
    #sudo cp -R ./$(HDAHCDINJECT) $(INSTDIR)
    #if [ "`which tag`" != "" ]; then sudo tag -a Blue $(INSTDIR)/$(HDAHCDINJECT); fi
    sudo cp $(HDAZML)/*.zml* $(SLE)/AppleHDA.kext/Contents/Resources
    if [ "`which tag`" != "" ]; then sudo tag -a Blue $(SLE)/AppleHDA.kext/Contents/Resources/*.zml*; fi
    make update_kernelcache

FORCED=/ForcedExtensions
.PHONY: install_hdax
install_hdax:
    sudo rm -Rf $(INSTDIR)/$(HDAINJECT)
    sudo rm -Rf $(INSTDIR)/$(HDAHCDINJECT)
    #sudo cp -R ./$(HDAHCDINJECT) $(FORCED)
    #if [ "`which tag`" != "" ]; then sudo tag -a Blue $(FORCED)/$(HDAHCDINJECT); fi
    sudo cp $(HDAZML)/*.zml* $(FORCED)/AppleHDA_Resources
    if [ "`which tag`" != "" ]; then sudo tag -a Blue $(FORCED)/AppleHDA_Resources/*.zml*; fi

.PHONY: install_usb
install_usb:
    sudo rm -Rf $(INSTDIR)/$(USBINJECT)
    sudo cp -R ./$(USBINJECT) $(INSTDIR)
    if [ "`which tag`" != "" ]; then sudo tag -a Blue $(INSTDIR)/$(USBINJECT); fi
    make update_kernelcache

.PHONY: install_backlight
install_backlight:
    sudo rm -Rf $(INSTDIR)/$(BACKLIGHTINJECT)
    sudo cp -R ./$(BACKLIGHTINJECT) $(INSTDIR)
    if [ "`which tag`" != "" ]; then sudo tag -a Blue $(INSTDIR)/$(BACKLIGHTINJECT); fi
    make update_kernelcache

