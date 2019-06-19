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

# Ensure that this is being run inside a CI container
if [ "${CI}" != "true" ];
then
	(>&2 echo "This script is designed to run inside a CI container only.")
	(>&2 echo "Aborting.")
	exit 1
fi

if [ -z ${PHP_VERSION+x} ];
then
	(>&2 echo "The PHP_VERSION is absent or empty.")
	(>&2 echo "Aborting.")
	exit 1
fi

phpenv config-rm xdebug.ini || true

major_version="$(echo $PHP_VERSION | cut -d '.' -f 1)"
if [ "$major_version" -eq "5" ];
then
	export ZEPHIR_VERSION="0.10.14"
	export ZEPHIR_PARSER_VERSION="v1.1.3"
	export ZEND_BACKEND="--backend=ZendEngine2"
fi
