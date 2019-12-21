#!/usr/bin/env bash
#
# This file is part of the Phalcon Builder.
#
# (c) Phalcon Team <team@phalcon.io>
#
# For the full copyright and license information, please view
# the LICENSE file that was distributed with this source code.
#
# If you did not receive a copy of the license it is available
# through the world-wide-web at the following url:
# https://license.phalcon.io

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

case "$PHP_VERSION" in
"5.5" | "5.6")
	cp debian/controls/legacy debian/control
	cp debian/postinsts/legacy debian/php5-phalcon.postinst
	cp debian/preinsts/legacy debian/php5-phalcon.preinst
	;;
"7.0" | "7.1"| "7.2" | "7.3" | "7.4")
	cp "debian/controls/php-${PHP_VERSION}" debian/control
	cp "debian/postinsts/php-${PHP_VERSION}" "debian/php${PHP_VERSION}-phalcon.postinst"
	cp "debian/preinsts/php-${PHP_VERSION}" "debian/php${PHP_VERSION}-phalcon.preinst"
	;;
*)
	(>&2 echo "Unsopported PHP version: ${PHP_VERSION}")
	(>&2 echo "Aborting.")
	exit 1
	;;
esac
