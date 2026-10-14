# Combined device+vendor config for the onyx Leica Camera port; -include this from device/xiaomi/onyx/BoardConfig.mk.

LEICACAMERA_PATH := vendor/xiaomi/onyx-leicacamera

# The camera blobs and the stock onyx vendor image legitimately carry some of the same paths and unstripped ELF prebuilts.
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# ro.miui.* / lens / privapp list read by MiuiCamera and the camera HAL
TARGET_SYSTEM_PROP += $(LEICACAMERA_PATH)/system.prop

# sepolicy for MiSyS, the camera HAL callbacks and the capture path
BOARD_VENDOR_SEPOLICY_DIRS += $(LEICACAMERA_PATH)/sepolicy/vendor
