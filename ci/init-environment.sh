#!/usr/bin/env bash
#
#  Phalcon Framework
#
#  Copyright (c) 2011-2017, Phalcon Team (https://www.phalconphp.com)
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

if [ ! -d "$HOME/cphalcon" ]; then
		echo -e "${PURPLE}Unable to locate 'cphalcon' directory. Exit${NC}"
		exit 1
fi

export LAST_COMMIT=$(cd $HOME/cphalcon; git rev-parse --short=8 HEAD)
export PARTIAL_VERSION=$(cd $HOME/cphalcon; cat config.json | jq ".version" | sed -E 's/\"//g')

if [ -z ${CLONE_BRANCH} ]; then
		usage_missed "CLONE_BRANCH"
fi

if [ -z ${NIGHTLY_BRANCH} ]; then
		usage_missed "NIGHTLY_BRANCH"
fi

if [ -z ${STABLE_BRANCH} ]; then
		usage_missed "STABLE_BRANCH"
fi

case ${CLONE_BRANCH} in
		$NIGHTLY_BRANCH*)
			_PACKAGECLOUD_REPO="phalcon/nightly"
			;;
		$STABLE_BRANCH*)
			_PACKAGECLOUD_REPO="phalcon/stable"
			;;
		*)
			echo -e "${PURPLE}Unsupported git branch. Exit${NC}"
			exit 1
		;;
esac

_RELEASE_VERSION=${RELEASE_VERSION}

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
		_RELEASE_VERSION+="+extra"
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
export RELEASE_VERSION=$_RELEASE_VERSION
export VERSION="${PARTIAL_VERSION}-${RELEASE_VERSION}-${LAST_COMMIT}"
export DOCKER_SUFFIX=$_DOCKER_SUFFIX
export ZEPHIR_VERSION=$(zephir version)
export FPM_VERSION=$(fpm --version)

printf "\n${GREEN}Stable branch/tag:${NC}      ${YELLOW}${STABLE_BRANCH}${NC}"
printf "\n${GREEN}Nightly branch/tag:${NC}     ${YELLOW}${NIGHTLY_BRANCH}${NC}"
printf "\n${GREEN}Clone branch:${NC}           ${YELLOW}${CLONE_BRANCH}${NC}"
printf "\n${GREEN}Release:${NC}                ${YELLOW}${RELEASE_VERSION}${NC}"
printf "\n${GREEN}Last commit SHA:${NC}        ${YELLOW}${LAST_COMMIT}${NC}"
printf "\n${GREEN}Partial version:${NC}        ${YELLOW}${PARTIAL_VERSION}${NC}"
printf "\n${GREEN}Full version name:${NC}      ${YELLOW}${VERSION}${NC}"
printf "\n${GREEN}Product:${NC}                ${YELLOW}${PRODUCT_EXT:-php-phalcon}${NC}"
printf "\n${GREEN}PHP version:${NC}            ${YELLOW}${PHP_VERSION:-undefined}${NC}"
printf "\n${GREEN}Zephir version:${NC}         ${YELLOW}${ZEPHIR_VERSION}${NC}"
printf "\n${GREEN}FPM version:${NC}            ${YELLOW}${FPM_VERSION}${NC}"
printf "\n${GREEN}Packagecloud repo:${NC}      ${YELLOW}${PACKAGECLOUD_REPO}${NC}"
printf "\n${GREEN}Docker image suffix:${NC}    ${YELLOW}${DOCKER_SUFFIX:-undefined}${NC}"
printf "\n${GREEN}Repo vendor:${NC}            ${YELLOW}${REPO_VENDOR:-undefined}${NC}"
printf "\n${GREEN}OS:${NC}                     ${YELLOW}${OS:-undefined}${NC}"
printf "\n${GREEN}DIST:${NC}                   ${YELLOW}${DIST:-undefined}${NC}"
printf "\n${GREEN}PACKAGE:${NC}                ${YELLOW}${PACKAGE}${NC}"
printf "\n"
