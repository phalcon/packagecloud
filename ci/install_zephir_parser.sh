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

# Ensure that this is being run inside a CI container
if [ "${CI}" != "true" ]; then
	echo "This script is designed to run inside a CI container only. Exiting"
	exit 1
fi

ZEPHIR_PARSER_VERSION=${ZEPHIR_PARSER_VERSION:-master}

git clone --depth=1 -v https://github.com/phalcon/php-zephir-parser.git -b ${ZEPHIR_PARSER_VERSION}

pushd php-zephir-parser

$(phpenv which phpize)
./configure --with-php-config=$(phpenv which php-config)
make
make install

popd

echo "extension=zephir_parser.so" >> $(phpenv root)/versions/$(phpenv version-name)/etc/conf.d/travis.ini

$(phpenv which php) --ri 'Zephir Parser'
