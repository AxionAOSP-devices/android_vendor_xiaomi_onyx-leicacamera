## Leica Camera Configuration for POCO F7 (onyx)

### How to?

Steps 3 and 4 are written for the root of your ROM workspace, the folder that contains `vendor/`. If your shell is already inside the clone, drop the `vendor/xiaomi/onyx-leicacamera/` prefix from every path below.

1. Add this line to your BoardConfig.mk
```
# Inherit from proprietary files for Leica Camera
-include vendor/xiaomi/onyx-leicacamera/BoardConfigVendor.mk
```
2. And this line to your device.mk
```
# Call the Leica Camera setup
$(call inherit-product-if-exists, vendor/xiaomi/onyx-leicacamera/onyx-leicacamera-vendor.mk)
```
3. Clone this repository to vendor/xiaomi/onyx-leicacamera, preferably with `--depth=1` to avoid having a big size locally clone
```sh
git clone --depth=1 -b lineage-23.2 https://gitlab.com/sachinbarange86/android_vendor_xiaomi_onyx-leicacamera vendor/xiaomi/onyx-leicacamera
```
4. The MiuiCamera APK is a Git LFS object and `repo sync` never fetches LFS, so pull it once or the build packages a 134-byte text pointer instead of the APK
```sh
git lfs install
```
Then, from the ROM workspace root:
```sh
git -C vendor/xiaomi/onyx-leicacamera lfs pull
```
Or from inside the clone:
```sh
git lfs pull
```
Check it before building, it must print `137627716`:
```sh
wc -c < vendor/xiaomi/onyx-leicacamera/proprietary/system/priv-app/MiuiCamera/MiuiCamera.apk
```
5. Start building and enjoy!
