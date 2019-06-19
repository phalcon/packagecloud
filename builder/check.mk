# This file is part of the Phalcon.
#
# (c) Phalcon Team <team@phalconphp.com>
#
# For the full copyright and license information, please view
# the LICENSE.txt file that was distributed with this source code.
#
# If you did not receive a copy of the license it is available
# through the world-wide-web at the following url:
# https://license.phalconphp.com

ifndef SOURCEDIR
$(error SOURCEDIR is undefined)
endif

ifeq ($(PHP_VERSION),)
$(error PHP_VERSION is undefined)
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
