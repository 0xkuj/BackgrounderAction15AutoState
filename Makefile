export TARGET = iphone:clang:14.5:14.5
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = backgrounderaction15autostate

backgrounderaction15autostate_FILES = Tweak.xm
backgrounderaction15autostate_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += backgrounderaction15autostateprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
