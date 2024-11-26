rm -rf .repo/local_manifests
repo init --depth=1 --no-repo-verify -u https://github.com/EverestOS-AOSP/manifest -b 15 --git-lfs -g default,-mips,-darwin,-notdefault

git clone https://github.com/1znaiv4/local_manifest.git --depth 1 -b everest .repo/local_manifests

/opt/crave/resync.sh

. build/envsetup.sh
lunch everest_mojito-ap3a-user
make installclean
make everest
