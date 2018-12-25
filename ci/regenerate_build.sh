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

if [ ${PHP_MAJOR_VERSION} -eq 7 ]; then
	rm -rf ${SOURCEDIR}/ext/kernel

	echo -e "zephir generate ${ZEND_BACKEND}"
	zephir generate ${ZEND_BACKEND}

	# Workaround to clean ZE3 kernel from ZE2
	OUTDATED_KERNEL_FILES=`git status --short | grep ' D ' | awk -F' D ' '{print $2}'`

	if [ ! -z ${OUTDATED_KERNEL_FILES+x} ]; then
		echo -e "Going to remove from git index:\n${OUTDATED_KERNEL_FILES}"
		echo $OUTDATED_KERNEL_FILES | xargs git rm -rf
	fi
else
	echo -e "zephir generate ${ZEND_BACKEND}"
	zephir generate ${ZEND_BACKEND}
fi

cd ${SOURCEDIR}/build

./install --phpize $(phpenv which phpize) --php-config $(phpenv which php-config)

phpenv config-add ${TRAVIS_BUILD_DIR}/ci/phalcon.ini

cd ${SOURCEDIR}/build
$(phpenv which php) gen-build.php
