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

function install_memcached() {
	local php_confd="$(phpenv root)/versions/$(phpenv version-name)/etc/conf.d"
	local php_extd="$(`phpenv which php-config` --extension-dir)"

	if [ ! -f "$php_extd/memcached.so" ];
	then
		cd /tmp
		phpenv local "${PHP_VERSION}" 1>/dev/null && phpenv rehash

		rm -rf memcached-latest && mkdir memcached-latest
		pecl download memcached 1> /dev/null
		tar -xf memcached-*.tgz -C ./memcached-latest --strip-components=1

		cd memcached-latest
		phpenv local "${PHP_VERSION}" 1>/dev/null && phpenv rehash

		phpize 1> /dev/null

		# TODO: Looks like "--disable-memcached-sasl" is required on Ubuntu 14.04
		./configure \
			--with-libmemcached-dir=/usr \
			--with-zlib-dir=/usr \
			--with-system-fastlz=no \
			--with-php-config=$(phpenv which php-config) \
			--enable-memcached-igbinary=no \
			--enable-memcached-msgpack=no \
			--enable-memcached \
			--enable-memcached-protocol=no \
			--enable-memcached-json=yes \
			--enable-memcached-session=yes \
			--disable-memcached-sasl \
			1>/dev/null

		make --silent -j"$(getconf _NPROCESSORS_ONLN)" 1>/dev/null
		make --silent install 1>/dev/null
	fi

	ls $php_extd | grep memcached.so 1> /dev/null
	echo extension=memcached.so > "$php_confd/memcached.ini"
}

function install_exts() {
	# We'll need to regenerate C-code on non-stable branches.
	# This is why we need to install missed extensions.
	if [ "$PACKAGECLOUD_REPO" = "nightly" ]
	then
		(>&1 echo "Installing PHP extensions...")
		case "$PHP_VERSION" in
			7.[0-9])
				(>&1 echo "  * psr")
				printf "\n" | pecl install --force psr 1> /dev/null

				(>&1 echo "  * redis")
				printf "\n" | pecl install --force redis 1> /dev/null

				(>&1 echo "  * memcached")
				install_memcached

				# will exit with 1 in case of extension absence
				php -m | grep psr 1> /dev/null
				php -m | grep redis 1> /dev/null
				php -m | grep memcached 1> /dev/null
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

unset os_version pkgname source downloaddir downloadfile
