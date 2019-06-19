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

SUPPORTED_IUS_VERSIONS=5.5 5.6 7.0 7.1 7.2 7.3

ifeq ($(filter $(PHP_MAJOR),$(SUPPORTED_IUS_VERSIONS)),)
$(error The $(PHP_MAJOR) is unsupported PHP version for $(REPO_VENDOR))
endif

ifeq ($(PHP_MAJOR),5.5)
PHP_VERSION=php55u
DOCKER_SUFFIX=-ius55
endif

ifeq ($(PHP_MAJOR),5.6)
PHP_VERSION=php56u
DOCKER_SUFFIX=-ius56
endif

ifeq ($(PHP_MAJOR),7.0)
PHP_VERSION=php70u
DOCKER_SUFFIX=-ius70
endif

ifeq ($(PHP_MAJOR),7.1)
PHP_VERSION=php71u
DOCKER_SUFFIX=-ius71
endif

ifeq ($(PHP_MAJOR),7.2)
PHP_VERSION=php72u
DOCKER_SUFFIX=-ius72
endif

ifeq ($(PHP_MAJOR),7.3)
PHP_VERSION=php73u
DOCKER_SUFFIX=-ius73
endif
