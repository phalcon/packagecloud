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

# Ensure that this is being run inside a CI container
if [ "${CI}" != "true" ];
then
	(>&2 echo "This script is designed to run inside a CI container only.")
	(>&2 echo "Aborting.")
	exit 1
fi

if [ -z ${BUILDTAB+x} ];
then
	(>&2 echo "The BUILDTAB is absent or empty.")
	(>&2 echo "Aborting.")
	exit 1
fi

# Expected format is:
# <OS> <DIST> <PACKAGE> <CLONE_BRANCH> <PHP_VERSION> <PACKAGECLOUD_REPO> <REPO_VENDOR>
IFS=';' read -ra build_conf <<< $(echo $BUILDTAB | tr -s "[:blank:]" ";")

if [ "${#build_conf[@]}" -ne "7" ];
then
	(>&2 echo "Invalid BUILDTAB format: \"${BUILDTAB}\".")
	(>&2 echo "Aborting.")
	exit 1
fi

export OS="${build_conf[0]}"
export DIST="${build_conf[1]}"
export PACKAGE="${build_conf[2]}"
export CLONE_BRANCH="${build_conf[3]}"
export PHP_VERSION="${build_conf[4]}"
export PACKAGECLOUD_REPO="${build_conf[5]}"
export REPO_VENDOR="${build_conf[6]}"
