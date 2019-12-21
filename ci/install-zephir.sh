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

if [ -z ${ZEPHIR_VERSION+x} ];
then
	(>&2 echo "The ZEPHIR_VERSION is absent or empty.")
	(>&2 echo "Aborting.")
	exit 1
fi

if [ -z ${PHP_VERSION+x} ];
then
	(>&2 echo "The PHP_VERSION is absent or empty.")
	(>&2 echo "Aborting.")
	exit 1
fi

if [ "${CLONE_BRANCH}" != "${NIGHTLY_BRANCH}" ];
then
	(>&1 echo "Zephir is needed only on '${NIGHTLY_BRANCH}' branch.")
	(>&1 echo "Current branch is: '${CLONE_BRANCH}'.")
	(>&1 echo "Skip installing Zephir.")
	exit 0
fi

pkgname=zephir
downloaddir="${HOME}/.cache/${pkgname}"
downloadfile="${pkgname}-${ZEPHIR_VERSION}.phar"
repo="https://github.com/phalcon/${pkgname}"
source="${repo}/releases/download/${ZEPHIR_VERSION}/${pkgname}.phar"
major_version="$(echo $PHP_VERSION | cut -d '.' -f 1)"

if [ "$major_version" -eq "7" ];
then
	if [ ! -f "${downloaddir}/${downloadfile}" ];
	then
		(>&1 echo "Downloading archive: ${source}")
		mkdir -p "${downloaddir}"
		wget --quiet --no-clobber -O "${downloaddir}/${downloadfile}" "${source}"
	fi

	if [ ! -f "${downloaddir}/${downloadfile}" ];
	then
		(>&2 echo "Unable to locate ${downloadfile} file.")
		(>&2 echo "Aborting.")
		exit 1
	fi

	chmod +x "${downloaddir}/${downloadfile}"
	ln -s "${downloaddir}/${downloadfile}" "${HOME}/bin/zephir"
else
	(>&1 echo "Downloading sorce: ${repo}.git")
	git clone -q --depth=1 "${repo}.git" -b ${ZEPHIR_VERSION} /tmp/zephir &> /dev/null
	cd /tmp/zephir

	ZEPHIRDIR="$( cd "$( dirname . )" && pwd )"
	sed "s#%ZEPHIRDIR%#$ZEPHIRDIR#g" bin/zephir > bin/zephir-cmd
	chmod 755 bin/zephir-cmd

	mkdir -p $HOME/bin

	cp bin/zephir-cmd $HOME/bin/zephir
	rm bin/zephir-cmd

	cd $HOME
fi

zephir
