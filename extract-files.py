#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#
# NOTE: --regenerate_makefiles rewrites Android.bp, Android.mk, BoardConfigVendor.mk, onyx-leicacamera-vendor.mk and .gitattributes - diff before committing, the hand-written comments and libgui_shim_miuicamera in PRODUCT_PACKAGES do not come back on their own.

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    # modules built by the main device tree land in vendor/xiaomi/onyx
    'vendor/xiaomi/onyx',
]

blob_fixups: blob_fixups_user_type = {
    'system/lib64/libcamera_algoup_jni.xiaomi.so': blob_fixup()
        .add_needed('libgui_shim_miuicamera.so')
        .sig_replace('08 AD 40 F9', '08 A9 40 F9'),
    'system/lib64/libcamera_mianode_jni.xiaomi.so': blob_fixup()
        .add_needed('libgui_shim_miuicamera.so'),
    'system/lib64/libmicampostproc_client.so': blob_fixup()
        .remove_needed('libhidltransport.so'),
    # Disabled: proprietary/ carries the already-patched Dyper build and patches/ is a git-am series against that dump, so a fresh extraction cannot be re-patched mechanically.
}  # fmt: skip

module = ExtractUtilsModule(
    'onyx-leicacamera',
    'xiaomi',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
