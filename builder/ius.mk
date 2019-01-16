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
#
# If you did not receive a copy of the license and are unable to
# obtain it through the world-wide-web, please send an email
# to license@phalconphp.com so we can send you a copy immediately.

SUPPORTED_IUS_VERSIONS=5.5 5.6 7.0 7.1 7.2

ifeq ($(filter $(PHP_MAJOR),$(SUPPORTED_IUS_VERSIONS)),)
$(error The $(PHP_MAJOR) is unsupported PHP version for $(REPO_VENDOR))
endif

ifeq ($(PHP_MAJOR),5.5)
PRODUCT_EXTRA=php55u-phalcon
PHP_VERSION=php55u
DOCKER_SUFFIX=-ius55
endif

ifeq ($(PHP_MAJOR),5.6)
PRODUCT_EXTRA=php56u-phalcon
PHP_VERSION=php56u
DOCKER_SUFFIX=-ius56
endif

ifeq ($(PHP_MAJOR),7.0)
PRODUCT_EXTRA=php70u-phalcon
PHP_VERSION=php70u
DOCKER_SUFFIX=-ius70
endif

ifeq ($(PHP_MAJOR),7.1)
PRODUCT_EXTRA=php71u-phalcon
PHP_VERSION=php71u
DOCKER_SUFFIX=-ius71
endif

ifeq ($(PHP_MAJOR),7.2)
PRODUCT_EXTRA=php72u-phalcon
PHP_VERSION=php72u
DOCKER_SUFFIX=-ius72
endif

ifeq ($(PHP_MAJOR),7.3)
PRODUCT_EXTRA=php73u-phalcon
PHP_VERSION=php73u
DOCKER_SUFFIX=-ius73
endif
