#!/bin/bash

# Initialize ROM manifest
repo init -u https://github.com/RisingTechOSS/android -b fifteen --git-lfs

# Sync the repo with force to ensure a clean sync
/opt/crave/resync.sh

# Cleanup
rm -rf device/xiaomi/ginkgo
rm -rf kernel/xiaomi/ginkgo
rm -rf vendor/xiaomi/ginkgo

# Clone Device Tree
git clone https://github.com/1znaiv4/device_xiaomi_ginkgo.git --depth 1 -b alpha-14 device/xiaomi/ginkgo

# Clone Kernel Tree
git clone https://github.com/tejas101k/kernel_xiaomi_ginkgo.git --depth 1 -b 15 kernel/xiaomi/ginkgo

# Clone Vendor Tree
git clone https://github.com/1znaiv4/vendor_xiaomi_ginkgo.git --depth 1 -b alpha-14 vendor/xiaomi/ginkgo

# ginkgo-stock_defconfig: set localversion to risingos
./kernel/xiaomi/ginkgo/scripts/config --file kernel/xiaomi/ginkgo/arch/arm64/configs/ginkgo-stock_defconfig --set-str "-Cuh-RisingOS"

# Set up the build environment
. build/envsetup.sh

# Choose the target device
riseup ginkgo user

# Build the ROM
rise b
