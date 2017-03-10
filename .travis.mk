#!/usr/bin/make -f
# -*- makefile -*-
#
#
# Phalcon Build Project
#
# Copyright (c) 2011-2017, Phalcon Team (https://www.phalconphp.com)
#
# This source file is subject to the New BSD License that is bundled
# with this package in the file LICENSE.txt
#
# If you did not receive a copy of the license and are unable to
# obtain it through the world-wide-web, please send an email
# to license@phalconphp.com so we can send you a copy immediately.
#
# Authors: Serghei Iakovlev <serghei@phalconphp.com>
#

SHELL=/bin/bash
ZEPHIR=$(shell command -v zephir 2> /dev/null)
PHP=php
SCRIPTDIR:=${CURDIR}

# See https://github.com/packpack/packpack/pull/63
PACK_REPO=https://github.com/sergeyklay/build.git
DOCKER_REPO=phalconphp/build
PACK_BRANCH=patch-1

PHP_VERSION?=
ZEND_BACKEND?=
REPO_VENDOR?=
RELEASE?=1
PRODUCT?=php-phalcon
PRODUCT_EXTRA=
NIGHTLY_BUILD_VERSION?=1
STABLE_BUILD_VERSION?=1

# List of supported OS
FEDORA:=fedora-rawhide fedora24 fedora23
CENTOS:=centos7 centos6
DEBIAN:=debian-sid debian-stretch debian-jessie debian-wheezy
UBUNTU:=ubuntu-yakkety ubuntu-xenial ubuntu-wily ubuntu-trusty ubuntu-precise

DEBS:=$(DEBIAN) $(UBUNTU)
RPMS:=$(FEDORA) $(CENTOS)

SUPPORTED_PACKAGES=rpm deb
SUPPORTED_IUS_VERSIONS=5.5 5.6 7.0

ifndef PHALCON_DIR
$(error PHALCON_DIR is undefined)
endif

ifndef TRAVIS_PHP_VERSION
$(error TRAVIS_PHP_VERSION is not available please install it first)
endif

ifeq ($(TRAVIS_PHP_VERSION),)
$(error TRAVIS_PHP_VERSION is undefined)
endif

ifndef CLONE_BRANCH
$(error CLONE_BRANCH is undefined)
endif

ifndef STABLE_BRANCH
$(error STABLE_BRANCH is undefined)
endif

ifndef NIGHTLY_BRANCH
$(error NIGHTLY_BRANCH is undefined)
endif

ifndef ZEPHIR
$(error Zephir is not available please install it first)
endif

ifndef OS
$(error OS is undefined)
endif

ifndef DIST
$(error DIST is undefined)
endif

ifndef PACKAGE
$(error PACKAGE is undefined)
endif

ifeq (el, $(OS))
BUILD_OS=centos
else
BUILD_OS=$(OS)
endif

_dist=$(shell echo "$(DIST)" | grep -c '^[0-9]\+$$')
ifneq ($(_dist),)
# Numeric dist, e.g. centos7 or fedora23
OSDIST=$(BUILD_OS)-$(DIST)
else
# Non-numeric dist, e.g. debian-sid, ubuntu-precise, etc.
OSDIST=$(BUILD_OS)$(DIST)
endif

ifeq ($(filter $(OSDIST),$(DEBS) $(RPMS)),)
$(error $(OSDIST) does not exist in supported OS)
endif

ifeq ($(filter $(PACKAGE), $(SUPPORTED_PACKAGES)),)
$(error $(PACKAGE) does not exist in supported package types)
endif

ifneq ($(CLONE_BRANCH), $(STABLE_BRANCH))
PACKAGECLOUD_REPO=phalcon/nightly7
BUILD_VERSION=$(NIGHTLY_BUILD_VERSION)
else
PACKAGECLOUD_REPO=phalcon/stable
BUILD_VERSION=$(STABLE_BUILD_VERSION)
endif

DOCKER_SUFFIX=

ifneq ($(REPO_VENDOR),)
ifeq ($(REPO_VENDOR),ius)

temp_version=$(shell echo "$(TRAVIS_PHP_VERSION)" | cut -d '.' -f 1,2)

ifeq ($(filter $(temp_version),$(SUPPORTED_IUS_VERSIONS)),)
$(error The $(TRAVIS_PHP_VERSION) is unsupported PHP version for $(REPO_VENDOR))
endif
ifneq ($(filter $(temp_version),5.5),)
PRODUCT_EXTRA=php55u-phalcon
PHP_VERSION=php55u
DOCKER_SUFFIX=-ius55
endif
ifneq ($(filter $(temp_version),5.6),)
PRODUCT_EXTRA=php56u-phalcon
PHP_VERSION=php56u
DOCKER_SUFFIX=-ius56
endif
ifneq ($(filter $(temp_version),7.0),)
PRODUCT_EXTRA=php70u-phalcon
PHP_VERSION=php70u
DOCKER_SUFFIX=-ius70
endif
else
$(error $(REPO_VENDOR) does not exist in supported repository vendors))
endif
endif

ifneq ($(PHP_VERSION),)
ifneq ($(filter $(OSDIST),$(DEBS)),)
temp=$(RELEASE)
RELEASE:=$(temp)+extra
endif
endif

ifeq ($(PHP_VERSION),7.0)
ifneq (,$(filter $(DIST),jessie trusty))
DOCKER_SUFFIX=-7.0
endif
endif

LAST_COMMIT=$(shell cd $(PHALCON_DIR); git rev-parse --short=8 HEAD)
VERSION=$(call grabv,$(PHALCON_DIR)/config.json)
ZEPHIR_VERSION=$(shell $(ZEPHIR) version)
DOCKER_IMAGE=$(OSDIST)$(DOCKER_SUFFIX)
DOCKER_TAG=$(DOCKER_REPO):$(OSDIST)$(DOCKER_SUFFIX)
BUILDDIR=$(PHALCON_DIR)/ext

all: package

gen-build: get-info
ifneq ($(CLONE_BRANCH), $(STABLE_BRANCH))
	$(info Regenerate build...)
	cd $(PHALCON_DIR); \
	$(ZEPHIR) fullclean; \
	$(ZEPHIR) generate ${ZEND_BACKEND}; \
	$(PHP) build/gen-build.php
endif

get-info:
	@echo ""
	@echo ""
	@echo "   Product ............................: $(PRODUCT)"
	@echo "   Product extra ......................: $(PRODUCT_EXTRA)"
	@echo ""
	@echo "   Product path .......................: $(PHALCON_DIR)"
	@echo "   Build path .........................: $(BUILDDIR)"
	@echo "   Current path .......................: $(SCRIPTDIR)"
	@echo ""
	@echo "   Stable branch/tag ..................: $(STABLE_BRANCH)"
	@echo "   Nightly branch/tag .................: $(NIGHTLY_BRANCH)"
	@echo "   Clone branch/tag ...................: $(CLONE_BRANCH)"
	@echo ""
	@echo "   Build version ......................: $(RELEASE)"
	@echo "   Last commit SHA ....................: $(LAST_COMMIT)"
	@echo "   Semantic version: ..................: $(VERSION)"
	@echo "   Full version name ..................: $(VERSION)-$(RELEASE)-$(LAST_COMMIT)"
	@echo ""
	@echo "   PHP version ........................: $(PHP_VERSION)"
	@echo "   Zephir version .....................: $(ZEPHIR_VERSION)"
	@echo ""
	@echo "   Repo vendor ........................: $(REPO_VENDOR)"
	@echo "   OS .................................: $(OS)"
	@echo "   Build OS ...........................: $(BUILD_OS)"
	@echo "   Distrib. version ...................: $(DIST)"
	@echo ""
	@echo "   Packagecloud repo ..................: $(PACKAGECLOUD_REPO)"
	@echo "   Docker repo ........................: $(DOCKER_REPO)"
	@echo "   Docker image .......................: $(DOCKER_IMAGE)"
	@echo "   Docker suffix ......................: $(DOCKER_SUFFIX)"
	@echo "   Fully qualified Docker image .......: $(DOCKER_TAG)"
	@echo "   Package type .......................: $(PACKAGE)"
	@echo ""
	@echo ""

source: gen-build
	$(info Create tarball...)
	git clone -q --depth=1 $(PACK_REPO) -b $(PACK_BRANCH) $(SCRIPTDIR)/packpack
	TARBALL_COMPRESSOR=gz packpack/packpack tarball

package: gen-build
	$(info Build package...)
	git clone -q --depth=1 $(PACK_REPO) -b $(PACK_BRANCH) $(SCRIPTDIR)/packpack
	./packpack/packpack

clean:
	$(info Clenup...)
	rm -rf $(SCRIPTDIR)/packpack

define grabv
$(shell cat "$1" | grep version | head -1 | sed -E 's|[\", ]||g' | cut -d ':' -f 2)
endef

.ONESHELL:
.SECONDARY:
.PHONY: source package clean gen-build get-info
