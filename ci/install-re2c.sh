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

if [ -z ${RE2C_VERSION+x} ];
then
	(>&2 echo "The RE2C_VERSION is absent or empty.")
	(>&2 echo "Aborting.")
	exit 1
fi

if [ "${RE2C_VERSION}" == "system" ];
then
	(>&1 echo "Use system re2c.")
	(>&1 echo "Skip installing re2c.")
	exit 0
fi

if [ "${CLONE_BRANCH}" != "${NIGHTLY_BRANCH}" ];
then
	(>&1 echo "re2c is needed only on '${NIGHTLY_BRANCH}' branch.")
	(>&1 echo "Current branch is: '${CLONE_BRANCH}'.")
	(>&1 echo "Skip installing re2c.")
	exit 0
fi

pkgname=re2c
source="https://github.com/skvadrik/${pkgname}/releases/download/${RE2C_VERSION}/${pkgname}-${RE2C_VERSION}.tar.gz"
downloaddir="${HOME}/.cache/${pkgname}/${pkgname}-${RE2C_VERSION}"
prefix="${HOME}/.local/opt/${pkgname}/${pkgname}-${RE2C_VERSION}"
bindir="${prefix}/bin"

if [ ! -f "${bindir}/re2c" ];
then
	if [ ! -d `dirname ${downloaddir}` ];
	then
		mkdir -p `dirname ${downloaddir}`
	fi

	cd `dirname ${downloaddir}`

	if [ ! -f "${pkgname}-${RE2C_VERSION}.tar.gz" ];
	then
		(>&1 echo "Downloading archive: ${source}")
		curl -sSL "$source" -o "${pkgname}-${RE2C_VERSION}.tar.gz"
	fi

	if [ ! -f "${pkgname}-${RE2C_VERSION}.tar.gz" ];
	then
		(>&2 echo "Unable to locate ${pkgname}-${RE2C_VERSION}.tar.gz file.")
		(>&2 echo "Aborting.")
		exit 1
	fi

	if [ ! -d "${downloaddir}" ];
	then
		mkdir -p "${downloaddir}"
		tar -zxf "${pkgname}-${RE2C_VERSION}.tar.gz"
	fi

	if [ ! -d "${downloaddir}" ];
	then
		(>&2 echo "Unable to locate re2c source.")
		(>&2 echo "Aborting.")
		exit 1
	fi

	if [ ! -d "${prefix}" ];
	then
		mkdir -p "${prefix}"
	fi

	cd "${downloaddir}"
	./configure --silent --prefix="${prefix}"

	make --silent -j"$(getconf _NPROCESSORS_ONLN)"
	make --silent install
fi

if [ ! -x "${bindir}/re2c" ];
then
	(>&2 echo "Unable to locate re2c executable.")
	(>&2 echo "Aborting.")
	exit 1
fi

mkdir -p ${HOME}/bin
ln -s "${bindir}/re2c" ${HOME}/bin/re2c

re2c --version
exit 0
