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

$(info Entering inside RPM-based OS)

ifndef PHP_VERSION
PHP_VERSION=""
endif
ifndef REPO_VENDOR
REPO_VENDOR=""
endif
ifndef PRODUCT_EXTRA
PRODUCT_EXTRA=""
endif

$(info $$PHP_VERSION is [${PHP_VERSION}])
$(info $$REPO_VENDOR is [${REPO_VENDOR}])
$(info $$PRODUCT_EXTRA is [${PRODUCT_EXTRA}])
