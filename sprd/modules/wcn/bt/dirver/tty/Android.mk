LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := sprdbt_tty.ko
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/root/lib/modules
LOCAL_STRIP_MODULE := keep_symbols
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

ifeq ($(TARGET_BUILD_VARIANT),user)
DEBUGMODE := BUILD=no
else
DEBUGMODE := $(DEBUGMODE)
endif

BOARD_SPRDWL_INTF ?= sc2332

$(LOCAL_PATH)/sprdbt_tty.ko: $(TARGET_PREBUILT_KERNEL)
	$(MAKE) -C $(shell dirname $@) ARCH=$(TARGET_KERNEL_ARCH) CROSS_COMPILE=$(KERNEL_CROSS_COMPILE) SPRDWL_PLATFORM=$(BOARD_SPRDWL_INTF) $(DEBUGMODE) KDIR=$(ANDROID_PRODUCT_OUT)/obj/KERNEL clean
	$(MAKE) -C $(shell dirname $@) ARCH=$(TARGET_KERNEL_ARCH) CROSS_COMPILE=$(KERNEL_CROSS_COMPILE) SPRDWL_PLATFORM=$(BOARD_SPRDWL_INTF) $(DEBUGMODE) KDIR=$(ANDROID_PRODUCT_OUT)/obj/KERNEL
	$(TARGET_STRIP) -d --strip-unneeded $@