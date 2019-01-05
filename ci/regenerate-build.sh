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

if [ "${CLONE_BRANCH}" != "${NIGHTLY_BRANCH}" ];
then
	(>&1 echo "Phalcon C code need to regenerated only on '${NIGHTLY_BRANCH}' branch.")
	(>&1 echo "Current branch is: '${CLONE_BRANCH}'.")
	(>&1 echo "Skip regenerate C code.")
	exit 0
fi

cd $SOURCEDIR

zephir fullclean
zephir generate $ZEND_BACKEND

cd $SOURCEDIR/build
$(phpenv which php) gen-build.php
