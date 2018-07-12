include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CatchaThief
CatchaThief_FILES = Tweak.xm capture.m

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
