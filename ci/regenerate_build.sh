#!/usr/bin/env bash
#
# Phalcon Build Project
#
# Copyright (c) 2011-2017, Phalcon Team (https://www.phalconphp.com)
#
# This source file is subject to the New BSD License that is bundled
# with this package in the file LICENSE.txt.
#
# If you did not receive a copy of the license and are unable to
# obtain it through the world-wide-web, please send an email
# to license@phalconphp.com so we can send you a copy immediately.
#
# Authors: Phalcon Framework Team <team@phalconphp.com>
#

set -e

cd ${SOURCEDIR}

zephir fullclean
zephir generate ${ZEND_BACKEND}

cd ${SOURCEDIR}/build

./install --phpize $(phpenv which phpize) --php-config $(phpenv which php-config)

phpenv config-add ${TRAVIS_BUILD_DIR}/ci/phalcon.ini

cd ${SOURCEDIR}/build
$(phpenv which php) gen-build.php
