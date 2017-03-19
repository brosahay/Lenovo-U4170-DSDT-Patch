#!/bin/bash
sudo chown root:admin /
sudo kextcache -system-prelinked-kernel
sudo kextcache -system-caches
