#!/usr/bin/env bash
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

if [ "${PACKAGE}" == "rpm" ]; then
	make -C ${TRAVIS_BUILD_DIR} ${BUILD_TARGET}
elif [ "${PACKAGE}" == "deb" ]; then
	make -C ${TRAVIS_BUILD_DIR} ${BUILD_TARGET}
else
	echo -e "Invalid PACKAGE value"
	exit 1
fi
