
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = nsasettings
catchaThiefSettings_FILES = catchaThiefSettingsListController.m
catchaThiefSettings_INSTALL_PATH = /Library/PreferenceBundles
catchaThiefSettings_FRAMEWORKS = UIKit
catchaThiefSettings_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
    $(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library.PreferenceLoader/Preferences$(ECHO_END)
    $(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/catchaThiefSettings.plist$(ECHO_END)
