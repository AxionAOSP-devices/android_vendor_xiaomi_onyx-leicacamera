# android_vendor_xiaomi_onyx-leicacamera

Leica camera vendor repo for the POCO F7 (`onyx`): the patched Dyper-based `com.android.camera` APK plus the MiSyS HAL, sepolicy and Leica assets it needs.

## Install

```sh
mkdir -p vendor/xiaomi
git clone https://github.com/Sachinpawar86/android_vendor_xiaomi_onyx-leicacamera vendor/xiaomi/onyx-leicacamera
git lfs pull -C vendor/xiaomi/onyx-leicacamera
```

Or as a manifest entry:

```xml
<project path="vendor/xiaomi/onyx-leicacamera" name="Sachinpawar86/android_vendor_xiaomi_onyx-leicacamera" revision="lineage-23.2" />
```

## Git LFS

Only `proprietary/system/priv-app/MiuiCamera/MiuiCamera.apk` is a Git-LFS object; everything else is a plain git file.

`repo sync` does not fetch LFS content, so after syncing a manifest clone you have to fetch it yourself or the build silently packages a 134-byte text pointer instead of the APK:

```sh
sudo apt install git-lfs            # once per machine
git lfs install
git lfs pull
```

Verify before starting a build (must print the real size, not `134`):

```sh
wc -c < vendor/xiaomi/onyx-leicacamera/proprietary/system/priv-app/MiuiCamera/MiuiCamera.apk
```

## Device tree hooks

```make
# device/xiaomi/onyx/BoardConfig.mk
-include vendor/xiaomi/onyx-leicacamera/BoardConfigVendor.mk

# device/xiaomi/onyx/device.mk
$(call inherit-product-if-exists, vendor/xiaomi/onyx-leicacamera/onyx-leicacamera-vendor.mk)
```
