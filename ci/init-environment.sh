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

if [ -z ${OS} ]; then
	usage_missed "OS"
fi

if [ "${OS}" == "el" ]; then
	_BUILD_OS=centos
else
	_BUILD_OS=${OS}
fi

case ${CLONE_BRANCH} in
	$NIGHTLY_BRANCH*)
		_PACKAGECLOUD_REPO="phalcon/nightly"
		_BUILD_VERSION=${NIGHTLY_BUILD_VERSION}
		;;
	$STABLE_BRANCH*)
		_PACKAGECLOUD_REPO="phalcon/stable"
		_BUILD_VERSION=${STABLE_BUILD_VERSION}
		;;
	*)
		echo -e "${PURPLE}Unsupported git branch. Exit${NC}"
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
	_BUILD_VERSION+="+extra"
	_PHP_VERSION=${PHP_VERSION}
fi

[[ "${DIST}" == "trusty" ]] && [[ "${PHP_VERSION}" == "7.0" ]] && _DOCKER_SUFFIX="-7.0"
[[ "${DIST}" == "jessie" ]] && [[ "${PHP_VERSION}" == "7.0" ]] && _DOCKER_SUFFIX="-7.0"

if [ ! -z "${DOCKER_SUFFIX}" ]; then
	_DOCKER_SUFFIX="-${DOCKER_SUFFIX}"
fi

if echo "${DIST}" | grep -c '^[0-9]\+$' > /dev/null; then
	# Numeric dist, e.g. centos7 or fedora23
	_OSDIST="${_BUILD_OS}${DIST}"
else
	# Non-numeric dist, e.g. debian-sid, ubuntu-precise, etc.
	_OSDIST="${_BUILD_OS}-${DIST}"
fi

export DOCKER_REPO="phalconphp/build"
export BUILD_OS=${_BUILD_OS}
export DOCKER_TAG=${DOCKER_REPO}:${_BUILD_OS}
export BUILD_TARGET=${_OSDIST}
export PRODUCT_EXT=$_PRODUCT_EXT
export PHP_VERSION=$_PHP_VERSION
export PACKAGECLOUD_REPO=$_PACKAGECLOUD_REPO
export BUILD_VERSION=$_BUILD_VERSION
export VERSION="${PARTIAL_VERSION}-${BUILD_VERSION}-${LAST_COMMIT}"
export DOCKER_SUFFIX=$_DOCKER_SUFFIX
export ZEPHIR_VERSION=$(zephir version)
export FPM_VERSION=$(fpm --version)

printf "\n${GREEN}Stable branch/tag:${NC}      ${YELLOW}${STABLE_BRANCH}${NC}"
printf "\n${GREEN}Nightly branch/tag:${NC}     ${YELLOW}${NIGHTLY_BRANCH}${NC}"
printf "\n${GREEN}Clone branch:${NC}           ${YELLOW}${CLONE_BRANCH}${NC}"
printf "\n${GREEN}Build version:${NC}          ${YELLOW}${BUILD_VERSION}${NC}"
printf "\n${GREEN}Last commit SHA:${NC}        ${YELLOW}${LAST_COMMIT}${NC}"
printf "\n${GREEN}Partial version:${NC}        ${YELLOW}${PARTIAL_VERSION}${NC}"
printf "\n${GREEN}Full version name:${NC}      ${YELLOW}${VERSION}${NC}"
printf "\n${GREEN}Product:${NC}                ${YELLOW}${PRODUCT_EXT:-php-phalcon}${NC}"
printf "\n${GREEN}PHP version:${NC}            ${YELLOW}${PHP_VERSION:-undefined}${NC}"
printf "\n${GREEN}Zephir version:${NC}         ${YELLOW}${ZEPHIR_VERSION}${NC}"
printf "\n${GREEN}FPM version:${NC}            ${YELLOW}${FPM_VERSION}${NC}"
printf "\n${GREEN}Packagecloud repo:${NC}      ${YELLOW}${PACKAGECLOUD_REPO}${NC}"
printf "\n${GREEN}Docker image suffix:${NC}    ${YELLOW}${DOCKER_SUFFIX:-undefined}${NC}"
printf "\n${GREEN}Repo vendor:${NC}            ${YELLOW}${REPO_VENDOR:-"NOT USED"}${NC}"
printf "\n${GREEN}OS:${NC}                     ${YELLOW}${OS:-undefined}${NC}"
printf "\n${GREEN}BUILD_OS:${NC}               ${YELLOW}${BUILD_OS}${NC}"
printf "\n${GREEN}Distrib. version:${NC}       ${YELLOW}${DIST:-undefined}${NC}"
printf "\n${GREEN}Docker repo:${NC}            ${YELLOW}${DOCKER_REPO}${NC}"
printf "\n${GREEN}Docker tag:${NC}             ${YELLOW}${DOCKER_TAG}${NC}"
printf "\n${GREEN}Makefile target:${NC}        ${YELLOW}${BUILD_TARGET}${NC}"
printf "\n${GREEN}Package type:${NC}           ${YELLOW}${PACKAGE}${NC}"
printf "\n"
