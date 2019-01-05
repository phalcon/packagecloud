#!/usr/bin/env bash
#
# This file is part of the Phalcon Builder.
#
# (c) Phalcon Team <team@phalconphp.com>
#
# For the full copyright and license information, please view
# the LICENSE file that was distributed with this source code.
#
# If you did not receive a copy of the license it is available
# through the world-wide-web at the following url:
# https://license.phalconphp.com
#
# If you did not receive a copy of the license and are unable to
# obtain it through the world-wide-web, please send an email
# to license@phalconphp.com so we can send you a copy immediately.

# -e	Exit immediately if a command exits with a non-zero status.
# -u	Treat unset variables as an error when substituting.
# -o	This setting prevents errors in a pipeline from being masked.
set -euo pipefail

# Ensure that this is being run inside a CI container
if [ "${CI}" != "true" ];
then
	(>&2 echo "This script is designed to run inside a CI container only.")
	(>&2 echo "Aborting.")
	exit 1
fi

if [ -z ${ZEPHIR_PARSER_VERSION+x} ];
then
	(>&2 echo "The ZEPHIR_PARSER_VERSION is absent or empty.")
	(>&2 echo "Aborting.")
	exit 1
fi

if [ "${CLONE_BRANCH}" != "${NIGHTLY_BRANCH}" ];
then
	(>&1 echo "Zephir Parser is needed only on '${NIGHTLY_BRANCH}' branch.")
	(>&1 echo "Current branch is: '${CLONE_BRANCH}'.")
	(>&1 echo "Skip installing Zephir Parser.")
	exit 0
fi

source=https://github.com/phalcon/php-zephir-parser.git

(>&1 echo "Cloning source: ${source}")
git clone --depth=1 -q "${source}" -b "${ZEPHIR_PARSER_VERSION}" 1>/dev/null

cd php-zephir-parser

$(phpenv which phpize)
./configure --with-php-config=$(phpenv which php-config) --enable-zephir_parser 1>/dev/null
make --silent -j"$(getconf _NPROCESSORS_ONLN)" 1>/dev/null
make --silent install 1>/dev/null

echo "extension=zephir_parser.so" >> $(phpenv root)/versions/$(phpenv version-name)/etc/conf.d/travis.ini
$(phpenv which php) --ri 'Zephir Parser'
