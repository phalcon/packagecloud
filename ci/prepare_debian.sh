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

echo -e "Current PHP version: ${TRAVIS_PHP_VERSION}"

if [ "$TRAVIS_PHP_VERSION" = "7.2" ]; then
	echo -e "Move ${TRAVIS_BUILD_DIR}/debian/control.${TRAVIS_PHP_VERSION} => ${TRAVIS_BUILD_DIR}/debian/control"
	mv -f ${TRAVIS_BUILD_DIR}/debian/control.${TRAVIS_PHP_VERSION} ${TRAVIS_BUILD_DIR}/debian/control
fi
