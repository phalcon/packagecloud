#!/usr/bin/env bash
#
# Phalcon Build Project
#
# Copyright (c) 2011-present, Phalcon Team (https://www.phalconphp.com)
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

echo -e "Current PHP version: ${TRAVIS_PHP_VERSION}"

if [ "$TRAVIS_PHP_VERSION" = "7.0" ] || [ "$TRAVIS_PHP_VERSION" = "7.1" ] || [ "$TRAVIS_PHP_VERSION" = "7.2" ]; then
	echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/php5-phalcon.*"
	rm -f ${TRAVIS_BUILD_DIR}/debian/php5-phalcon.*

	if [ "$TRAVIS_PHP_VERSION" = "7.0" ]; then
		echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/php7.1-phalcon.*"
		rm -f ${TRAVIS_BUILD_DIR}/debian/php7.1-phalcon.*
		echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/php7.2-phalcon.*"
		rm -f ${TRAVIS_BUILD_DIR}/debian/php7.2-phalcon.*
		echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/control.7.1"
		rm -f ${TRAVIS_BUILD_DIR}/debian/control.7.1
		echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/control.7.2"
		rm -f ${TRAVIS_BUILD_DIR}/debian/control.7.2
	fi

	if [ "$TRAVIS_PHP_VERSION" = "7.1" ]; then
		echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/php7.0-phalcon.*"
		rm -f ${TRAVIS_BUILD_DIR}/debian/php7.0-phalcon.*
		echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/php7.2-phalcon.*"
		rm -f ${TRAVIS_BUILD_DIR}/debian/php7.2-phalcon.*
		echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/control.7.0"
		rm -f ${TRAVIS_BUILD_DIR}/debian/control.7.0
		echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/control.7.2"
		rm -f ${TRAVIS_BUILD_DIR}/debian/control.7.2
	fi

	if [ "$TRAVIS_PHP_VERSION" = "7.2" ]; then
		echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/php7.0-phalcon.*"
		rm -f ${TRAVIS_BUILD_DIR}/debian/php7.0-phalcon.*
		echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/php7.1-phalcon.*"
		rm -f ${TRAVIS_BUILD_DIR}/debian/php7.1-phalcon.*
		echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/control.7.0"
		rm -f ${TRAVIS_BUILD_DIR}/debian/control.7.0
		echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/control.7.1"
		rm -f ${TRAVIS_BUILD_DIR}/debian/control.7.1
	fi

	echo -e "Move ${TRAVIS_BUILD_DIR}/debian/control.${TRAVIS_PHP_VERSION} => ${TRAVIS_BUILD_DIR}/debian/control"
	mv -f ${TRAVIS_BUILD_DIR}/debian/control.${TRAVIS_PHP_VERSION} ${TRAVIS_BUILD_DIR}/debian/control
else
	echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/php7*"
	rm -f ${TRAVIS_BUILD_DIR}/debian/php7*

	echo -e "Remove ${TRAVIS_BUILD_DIR}/debian/control.7*"
	rm -f ${TRAVIS_BUILD_DIR}/debian/control.7*
fi
