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

Only `proprietary/system/priv-app/MiuiCamera/MiuiCamera.apk` is a Git-LFS object; everything else is a plain git file.

## Device tree hooks

```make
# device/xiaomi/onyx/BoardConfig.mk
-include vendor/xiaomi/onyx-leicacamera/BoardConfigVendor.mk

# device/xiaomi/onyx/device.mk
$(call inherit-product-if-exists, vendor/xiaomi/onyx-leicacamera/onyx-leicacamera-vendor.mk)
```
