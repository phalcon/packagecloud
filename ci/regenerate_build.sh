#!/usr/bin/env bash
#
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

set -e

cd ${SOURCEDIR}

zephir fullclean

echo -e "zephir generate ${ZEND_BACKEND}"
zephir generate ${ZEND_BACKEND}

cd ${SOURCEDIR}/build

# TODO: Do we need still need install Phalcon to regenerate optimized source?
./install --phpize $(phpenv which phpize) --php-config $(phpenv which php-config)
phpenv config-add ${TRAVIS_BUILD_DIR}/ci/phalcon.ini

cd ${SOURCEDIR}/build
$(phpenv which php) gen-build.php
