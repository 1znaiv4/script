#!/bin/bash

# Cleanup before repo initialization
rm -rf .repo/local_manifests/

# Initialize rom manifest
repo init -u https://github.com/ProjectEverest/manifest -b 14 --git-lfs

# Sync the repo
/opt/crave/resync.sh

# Clone Device Tree
git clone https://github.com/ProjectEverest-Devices/android_device_xiaomi_mojito.git --depth 1 -b 14 device/xiaomi/mojito
git clone https://github.com/ProjectEverest-Devices/android_device_xiaomi_sm6150-common.git --depth 1 -b 14 device/xiaomi/sm6150-common

# Clone Kernel Tree
git clone https://github.com/ProjectEverest-Devices/android_kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/mojito

# Clone Vendor Tree
git clone https://gitlab.com/bliss-mojito/android_vendor_xiaomi_mojito.git --depth 1 -b 14 vendor/xiaomi/mojito
git clone https://gitlab.com/bliss-mojito/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 14 vendor/xiaomi/sm6150-common

# Clone Hardware Tree
git clone https://github.com/ProjectEverest-Devices/android_hardware_xiaomi.git --depth 1 -b mojito hardware/xiaomi

# Set up the build environment
. build/envsetup.sh
lunch lineage_mojito-user
mka everest -j$(nproc --all)
