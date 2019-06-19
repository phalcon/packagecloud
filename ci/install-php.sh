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

if [ -z ${PHP_VERSION+x} ];
then
	(>&2 echo "The PHP_VERSION variable is absent or empty.")
	(>&2 echo "Aborting.")
	exit 1
fi

if [ -z ${PACKAGECLOUD_REPO+x} ];
then
	(>&2 echo "The PACKAGECLOUD_REPO variable is absent or empty.")
	(>&2 echo "Aborting.")
	exit 1
fi

install_exts() {
	# We'll need to regenerate C-code on non-stable branches.
	# This is why we need to install missed extensions.
	if [ "$PACKAGECLOUD_REPO" != "stable" ]
	then
		case "$PHP_VERSION" in
			7.[0-9])
				printf "\n" | pecl install --force psr &> /dev/null
				printf "\n" | pecl install --force redis &> /dev/null
				# will exit with 1 in case of extension absence
				php -m | grep psr &> /dev/null
				php -m | grep redis &> /dev/null
				;;
			*)
				(>&2 echo "PHP v${PHP_VERSION} is not supported by Phalcon ${PACKAGECLOUD_REPO}.")
				(>&2 echo "Aborting.")
				exit 1
				;;
		esac
	fi
}

# Travis creates symbolic links to the real version like:
# ~/.phpenv/versions/7.2 -> ~/.phpenv/versions/7.2.13
if [ -L "${HOME}/.phpenv/versions/${PHP_VERSION}" ];
then
	phpenv global "${PHP_VERSION}"
	phpenv rehash
	php -v

	install_exts
	exit 0
fi

os_version=14.04
pkgname=php
source="https://s3.amazonaws.com/travis-php-archives/binaries/ubuntu/${os_version}/x86_64/${pkgname}-${PHP_VERSION}.tar.bz2"
downloaddir="${HOME}/.cache/${pkgname}/ubuntu-${os_version}"
downloadfile="${pkgname}-${PHP_VERSION}.tar.bz2"

if [ ! -f "${downloaddir}/${downloadfile}" ];
then
	(>&1 echo "Downloading archive: ${source}")
	mkdir -p "${downloaddir}" && cd "${downloaddir}"
	curl -s -o $downloadfile "${source}"
fi

if [ ! -f "${downloaddir}/${downloadfile}" ];
then
	(>&2 echo "Unable to locate ${downloadfile} file.")
	(>&2 echo "Aborting.")
	exit 1
fi

(>&1 echo "${PHP_VERSION} is not pre-installed; installing")
cd "${downloaddir}"
tar xjf "${downloadfile}" --directory /

phpenv global "${PHP_VERSION}"
phpenv rehash
php -v

install_exts
