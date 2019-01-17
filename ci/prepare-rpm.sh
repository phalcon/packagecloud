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

# Ensure that this is being run for an expected rpm maintainer
if [ "${REPO_VENDOR}" != "ius" ];
then
	(>&2 echo "Currently, only IUS (remi) package creation is supported.")
	(>&2 echo "Aborting.")
	exit 1
fi

case "$PHP_VERSION" in
"5.5" | "5.6" | "7.0" | "7.1"| "7.2" | "7.3" )
	cp "rpm/specs/remi-php-${PHP_VERSION}.spec" rpm/php-phalcon.spec
	;;
*)
	(>&2 echo "Unsopported PHP version: ${PHP_VERSION}")
	(>&2 echo "Aborting.")
	exit 1
	;;
esac

(find rpm -mindepth 1 -maxdepth 1 -name php-phalcon.spec -type f | egrep '.*' 2>&1 >/dev/null) || \
	(>&2 echo "Can't find RPM spec in rpm/ directory."; >&2 echo "Aborting."; exit 1)
