TARGET = iphone:clang:10.1:10.0
# DEBUG = 0
ARCHS = armv7 arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FilePhotos
FilePhotos_FILES = Tweak.xm BJFilePickerController.m
FilePhotos_FRAMEWORKS = UIKit PhotosUI
FilePhotos_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
