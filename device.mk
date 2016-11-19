#
# Copyright (C) 2015 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Local overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# make MTP,ADB happier
PRODUCT_COPY_FILES += $(LOCAL_PATH)/configs/init.qcom.usb.rc:root/init.qcom.usb.rc

# Inherit from a5-common
$(call inherit-product, device/htc/a5-common/a5-common.mk)

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/base/nfc-extras/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml

# NFC
ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/configs/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/configs/nfcee_access_debug.xml
endif

# See https://github.com/CyanogenMod/android_external_libnfc-nci/blob/cm-14.1/halimpl/pn54x/Android.mk#L21
# for magic values of NXP_CHIP_TYPE.
NXP_CHIP_TYPE := 1

PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml \
    $(LOCAL_PATH)/configs/libnfc-nxp.conf:system/etc/libnfc-nxp.conf \
    $(LOCAL_PATH)/configs/libnfc-brcm.conf:system/etc/libnfc-brcm.conf

PRODUCT_PACKAGES += \
    NfcNci \
    Tag \
    com.android.nfc_extras \
    nfc_nci.pn54x.default 

# Overrides
PRODUCT_COPY_FILES_OVERRIDES := \
    $(LOCAL_PATH)/configs/apns-conf.xml:system/etc/apns-conf.xml
