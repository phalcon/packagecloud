#!/usr/bin/env bash
#
#  Phalcon Framework
#
#  Copyright (c) 2011-present Phalcon Team (https://www.phalconphp.com)
#
#  This source file is subject to the New BSD License that is bundled
#  with this package in the file LICENSE.txt.
#
#  If you did not receive a copy of the license and are unable to
#  obtain it through the world-wide-web, please send an email
#  to license@phalconphp.com so we can send you a copy immediately.
#
#  Authors: Phalcon Framework Team <team@phalconphp.com>

# Ensure that this is being run inside a CI container
if [ "${CI}" != "true" ]; then
    echo "This script is designed to run inside a CI container only. Exiting"
    exit 1
fi

ZEPHIR_PARSER_VERSION=${ZEPHIR_PARSER_VERSION:-development}
PHP_MAJOR=`$(phpenv which php-config) --version | cut -d '.' -f 1,2`

LOCAL_SRC_DIR=${HOME}/.cache/zephir-parser/src
LOCAL_LIB_DIR=${HOME}/.local/lib
LOCAL_LIBRARY=${LOCAL_LIB_DIR}/zephir-parser-${ZEPHIR_PARSER_VERSION}-${PHP_MAJOR}.so

EXTENSION_DIR=`$(phpenv which php-config) --extension-dir`

if [ ! -f ${LOCAL_LIBRARY} ]; then
	rm -rf ${LOCAL_SRC_DIR}

    mkdir -p ${LOCAL_SRC_DIR}
    mkdir -p ${LOCAL_LIB_DIR}

    git clone --depth=1 -v https://github.com/phalcon/php-zephir-parser.git -b ${ZEPHIR_PARSER_VERSION} ${LOCAL_SRC_DIR}

    bash ${LOCAL_SRC_DIR}/install

    if [ ! -f "${EXTENSION_DIR}/zephir_parser.so" ]; then
        echo "Unable to locate installed zephir_parser.so"
        exit 1
    fi

    cp "${EXTENSION_DIR}/zephir_parser.so" ${LOCAL_LIBRARY}
fi

echo "[Zephir Parser]" > ${HOME}/.phpenv/versions/$(phpenv version-name)/etc/conf.d/zephir-parser.ini
echo "extension=${LOCAL_LIBRARY}" >> ${HOME}/.phpenv/versions/$(phpenv version-name)/etc/conf.d/zephir-parser.ini

php --ri 'Zephir Parser'
