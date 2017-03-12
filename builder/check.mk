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

ifndef SOURCEDIR
$(error SOURCEDIR is undefined)
endif

ifeq ($(TRAVIS_PHP_VERSION),)
$(error TRAVIS_PHP_VERSION is undefined)
endif

ifndef CLONE_BRANCH
$(error CLONE_BRANCH is undefined)
endif

ifndef STABLE_BRANCH
$(error STABLE_BRANCH is undefined)
endif

ifndef NIGHTLY_BRANCH
$(error NIGHTLY_BRANCH is undefined)
endif

ifndef OS
$(error OS is undefined)
endif

ifndef DIST
$(error DIST is undefined)
endif

ifndef PACKAGE
$(error PACKAGE is undefined)
endif
