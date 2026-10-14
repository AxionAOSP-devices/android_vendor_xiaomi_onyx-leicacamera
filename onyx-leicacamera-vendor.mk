# Combined device+vendor product config for the onyx Leica Camera port; inherit this from device/xiaomi/onyx/device.mk.

LEICACAMERA_PATH := vendor/xiaomi/onyx-leicacamera

# Soong namespace for the MiSyS HAL, the shim and the blobs
PRODUCT_SOONG_NAMESPACES += \
    $(LEICACAMERA_PATH)

# Camera
$(call soong_config_set_bool,camera,override_format_from_reserved,true)

# MiSyS (watermark / MIVI session) service + the libs the app dlopens
PRODUCT_PACKAGES += \
    vendor.xiaomi.hardware.misys-service \
    libgui_shim_miuicamera \
    libcamera_algoup_jni.xiaomi \
    libcamera_mianode_jni.xiaomi \
    libmicampostproc_client \
    vendor.xiaomi.hardware.campostproc@1.0 \
    MiuiCamera

# Public libraries the app loads from /system/lib64
PRODUCT_COPY_FILES += \
    $(LEICACAMERA_PATH)/configs/public.libraries-xiaomi.txt:$(TARGET_COPY_OUT_SYSTEM)/etc/public.libraries-xiaomi.txt

# Priv-app permissions
PRODUCT_COPY_FILES += \
    $(LEICACAMERA_PATH)/configs/privapp-permissions-miuicamera.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-miuicamera.xml

# Hidden API allowlist (com.android.camera uses non-SDK interfaces)
PRODUCT_COPY_FILES += \
    $(LEICACAMERA_PATH)/configs/miuicamera-hiddenapi-package-allowlist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/miuicamera-hiddenapi-package-allowlist.xml

# Framework compatibility matrix for vendor.xiaomi.hardware.misys.common
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(LEICACAMERA_PATH)/configs/compatibility_matrix.xml

# Auto-grant camera / mic / location to the camera app
PRODUCT_COPY_FILES += \
    $(LEICACAMERA_PATH)/configs/miuicamera-permissions.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/default-permissions/miuicamera-permissions.xml

# Leica filter LUTs and watermark assets absent from the onyx stock dump (taken from klee), built straight into /odm so no runtime overlay is needed.
PRODUCT_COPY_FILES += \
    $(LEICACAMERA_PATH)/prebuilts/odm/etc/camera/videofilter/169_LeicaChrome.png:$(TARGET_COPY_OUT_ODM)/etc/camera/videofilter/169_LeicaChrome.png \
    $(LEICACAMERA_PATH)/prebuilts/odm/etc/camera/videofilter/170_LeicaClassic.png:$(TARGET_COPY_OUT_ODM)/etc/camera/videofilter/170_LeicaClassic.png \
    $(LEICACAMERA_PATH)/prebuilts/odm/etc/camera/videofilter/171_LeicaContemporary.png:$(TARGET_COPY_OUT_ODM)/etc/camera/videofilter/171_LeicaContemporary.png \
    $(LEICACAMERA_PATH)/prebuilts/odm/etc/camera/videofilter/172_LeicaEternal.png:$(TARGET_COPY_OUT_ODM)/etc/camera/videofilter/172_LeicaEternal.png \
    $(LEICACAMERA_PATH)/prebuilts/odm/etc/camera/videofilter/173_LeicaBrass.png:$(TARGET_COPY_OUT_ODM)/etc/camera/videofilter/173_LeicaBrass.png \
    $(LEICACAMERA_PATH)/prebuilts/odm/etc/camera/videofilter/174_LeicaTeal.png:$(TARGET_COPY_OUT_ODM)/etc/camera/videofilter/174_LeicaTeal.png \
    $(LEICACAMERA_PATH)/prebuilts/odm/etc/camera/videofilter/175_LeicaIModelA.png:$(TARGET_COPY_OUT_ODM)/etc/camera/videofilter/175_LeicaIModelA.png \
    $(LEICACAMERA_PATH)/prebuilts/odm/etc/camera/72.png:$(TARGET_COPY_OUT_ODM)/etc/camera/72.png \
    $(LEICACAMERA_PATH)/prebuilts/odm/etc/camera/73.png:$(TARGET_COPY_OUT_ODM)/etc/camera/73.png

# Watermark image symlinks the HAL expects under /data/vendor/camera
PRODUCT_COPY_FILES += \
    $(LEICACAMERA_PATH)/init/leicacamera.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/leicacamera.rc
