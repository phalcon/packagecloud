#!/usr/bin/env bash
#
#  Phalcon Framework
#
#  Copyright (c) 2011-2016, Phalcon Team (https://www.phalconphp.com)
#
#  This source file is subject to the New BSD License that is bundled
#  with this package in the file https://www.phalconphp.com/LICENSE.txt
#
#  If you did not receive a copy of the license and are unable to
#  obtain it through the world-wide-web, please send an email
#  to license@phalconphp.com so we can send you a copy immediately.
#
#  Authors: Andres Gutierrez <andres@phalconphp.com>
#           Serghei Iakovlev <serghei@phalconphp.com>
#

PURPLE="\033[0;35m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m"

export_ius_vars() {
		case ${TRAVIS_PHP_VERSION} in
			5.5*)
				_PRODUCT_EXT=php55u-phalcon
				_PHP_VERSION=php55u
				_DOCKER_SUFFIX=-ius55
				;;
			5.6*)
				_PRODUCT_EXT=php56u-phalcon
				_PHP_VERSION=php56u
				_DOCKER_SUFFIX=-ius56
				;;
			7.0*)
				_PRODUCT_EXT=php70u-phalcon
				_PHP_VERSION=php70u
				_DOCKER_SUFFIX=-ius70
				;;
			*)
				echo -e "${PURPLE}Unsupported PHP version. Exit${NC}"
				exit 1
				;;
		esac
}

usage_missed() {
		echo -e "${PURPLE}Missed \$$1 variable. Exit${NC}"
		exit 1
}

if [ ! -d "cphalcon" ]; then
		echo -e "${PURPLE}Unable to locate 'cphalcon' directory. Exit${NC}"
		exit 1
fi

export LAST_COMMIT=$(cd cphalcon; git rev-parse --short=8 HEAD)
export PARTIAL_VERSION=$(cd cphalcon; cat config.json | jq ".version" | sed -E 's/\"//g')

if [ -z ${PHALCON_VERSION} ]; then
		usage_missed "PHALCON_VERSION"
fi

if [ -z ${NIGHTLY_VERSION} ]; then
		usage_missed "NIGHTLY_VERSION"
fi

if [ -z ${STABLE_VERSION} ]; then
		usage_missed "STABLE_VERSION"
fi


if [ -z ${TRAVIS_BUILD_NUMBER} ]; then
		usage_missed "TRAVIS_BUILD_NUMBER"
fi

case ${PHALCON_VERSION} in
		$NIGHTLY_VERSION*)
			_PACKAGECLOUD_REPO="phalcon/nightly"
			_RELEASE=$TRAVIS_BUILD_NUMBER
			;;
		$STABLE_VERSION*)
			_PACKAGECLOUD_REPO="phalcon/stable"
			_RELEASE=$STABLE_RELEASE
			;;
		*)
			echo -e "${PURPLE}Unsupported Phalcon version branch. Exit${NC}"
			exit 1
		;;
esac


if [ ! -z ${REPO_VENDOR} ]; then
		case ${REPO_VENDOR} in
			ius*)
				export_ius_vars
				;;
			*)
				echo -e "${PURPLE}Unsupported PHP version. Exit${NC}"
				exit 1
				;;
		esac
elif [ ! -z "${PHP_VERSION}" ]; then
		_RELEASE+="+extra"
		_PHP_VERSION=${PHP_VERSION}
fi

[[ "${DIST}" == "trusty" ]] && [[ "${PHP_VERSION}" == "7.0" ]] && _DOCKER_SUFFIX="-7.0"
[[ "${DIST}" == "jessie" ]] && [[ "${PHP_VERSION}" == "7.0" ]] && _DOCKER_SUFFIX="-7.0"

if [ ! -z "${DOCKER_SUFFIX}" ]; then
		_DOCKER_SUFFIX="-${DOCKER_SUFFIX}"
fi

export PRODUCT_EXT=$_PRODUCT_EXT
export PHP_VERSION=$_PHP_VERSION
export PACKAGECLOUD_REPO=$_PACKAGECLOUD_REPO
export RELEASE=$_RELEASE
export VERSION="${PARTIAL_VERSION}-${RELEASE}-${LAST_COMMIT}"
export DOCKER_SUFFIX=$_DOCKER_SUFFIX

printf "\n\t${GREEN}Stable Phalcon version:${NC}   ${YELLOW}$STABLE_VERSION${NC}"
printf "\n\t${GREEN}Nightly Phalcon version:${NC}  ${YELLOW}$NIGHTLY_VERSION${NC}"
printf "\n\t${GREEN}Current Phalcon version:${NC}  ${YELLOW}$PHALCON_VERSION${NC}"
printf "\n\t${GREEN}Release:${NC}                  ${YELLOW}$RELEASE${NC}"
printf "\n\t${GREEN}Last commit SHA:${NC}          ${YELLOW}$LAST_COMMIT${NC}"
printf "\n\t${GREEN}Partial version:${NC}          ${YELLOW}$PARTIAL_VERSION${NC}"
printf "\n\t${GREEN}Full version:${NC}             ${YELLOW}$VERSION${NC}"
printf "\n\t${GREEN}Product:${NC}                  ${YELLOW}${PRODUCT_EXT:-php-phalcon}${NC}"
printf "\n\t${GREEN}PHP version:${NC}              ${YELLOW}${PHP_VERSION:-undefined}${NC}"
printf "\n\t${GREEN}Packagecloud repo:${NC}        ${YELLOW}$PACKAGECLOUD_REPO${NC}"
printf "\n\t${GREEN}Docker suffix:${NC}            ${YELLOW}${DOCKER_SUFFIX:-undefined}${NC}"
printf "\n\t${GREEN}Repo vendor:${NC}              ${YELLOW}${REPO_VENDOR:-undefined}${NC}"
printf "\n\t${GREEN}OS:${NC}                       ${YELLOW}${OS:-undefined}${NC}"
printf "\n\t${GREEN}DIST:${NC}                     ${YELLOW}${DIST:-undefined}${NC}"
printf "\n\t${GREEN}PACK:${NC}                     ${YELLOW}$PACK${NC}"
printf "\n"
