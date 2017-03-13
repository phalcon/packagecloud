#
# Phalcon Build Project
#
# Copyright (c) 2011-2017, Phalcon Team (https://www.phalconphp.com)
#
# This source file is subject to the New BSD License that is bundled
# with this package in the file LICENSE.txt
#
# If you did not receive a copy of the license and are unable to
# obtain it through the world-wide-web, please send an email
# to license@phalconphp.com so we can send you a copy immediately.
#
# Authors: Serghei Iakovlev <serghei@phalconphp.com>
#

REPO_VENDOR ?=
BUILD_RELEASE = $(RELEASE)

ifeq ($(PACKAGE),rmp)
$(info Patching RPM release)
ifneq ($(REPO_VENDOR),)
RELEASE := $(BUILD_RELEASE).$(REPO_VENDOR)
endif
else ifeq ($(PACKAGE),deb)
$(info Patching DEB release)
else
$(info Do nothing)
endif
