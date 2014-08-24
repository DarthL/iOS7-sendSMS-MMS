export ARCHS = armv7 armv7s arm64
export TARGET = iphone:7.1:4.3
include theos/makefiles/common.mk

TWEAK_NAME = sendsmsmms
sendsmsmms_FILES = Tweak.xm
sendsmsmms_FRAMEWORKS = UIKit Foundation
sendsmsmms_PRIVATE_FRAMEWORKS = ChatKit AppSupport IMCore IMFoundation
sendsmsmms_LIBRARIES = rocketbootstrap

sendsmsmms_CFLAGS = -fobjc-arc
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileSMS "
