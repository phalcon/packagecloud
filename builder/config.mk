# This file is part of the Phalcon.
#
# (c) Phalcon Team <team@phalconphp.com>
#
# For the full copyright and license information, please view
# the LICENSE.txt file that was distributed with this source code.
#
# If you did not receive a copy of the license it is available
# through the world-wide-web at the following url:
# https://license.phalconphp.com
#
# If you did not receive a copy of the license and are unable to
# obtain it through the world-wide-web, please send an email
# to license@phalconphp.com so we can send you a copy immediately.

CHANGELOG_NAME=Phalcon Team
CHANGELOG_EMAIL=build@phalconphp.com
CHANGELOG_TEXT=Automated build. See details at release page https://github.com/phalcon/cphalcon/releases

PACK_REPO=https://github.com/packpack/packpack.git
PACK_BRANCH=master
PACK_COMMIT=30ff7b51654c19b8919d01ca8d4aa480e87e8241

DOCKER_REPO=phalconphp/build

PHP_VERSION?=
ZEND_BACKEND?=
REPO_VENDOR?=
RELEASE=
PRODUCT?=php-phalcon
PRODUCT_EXTRA=
NIGHTLY_BUILD_VERSION?=1
STABLE_BUILD_VERSION?=1

# List of supported OS
FEDORA:=fedora-rawhide fedora24 fedora23
CENTOS:=centos7 centos6
DEBIAN:=debian-sid debian-stretch debian-jessie debian-wheezy
UBUNTU:=ubuntu-bionic ubuntu-xenial ubuntu-trusty

DEBS:=$(DEBIAN) $(UBUNTU)
RPMS:=$(FEDORA) $(CENTOS)

SUPPORTED_PACKAGES=rpm deb
SUPPORTED_VENDORS=ius

PHP_MAJOR=$(shell echo "$(TRAVIS_PHP_VERSION)" | cut -d '.' -f 1,2)

ifeq (el,$(OS))
BUILD_OS=centos
else
BUILD_OS=$(OS)
endif

ifneq ($(shell echo "$(DIST)" | grep '^[0-9]\+$$'),)
# Non-numeric dist, e.g. debian-sid, ubuntu-precise, etc.
OSDIST=$(BUILD_OS)$(DIST)
else
# Numeric dist, e.g. centos7 or fedora23
OSDIST=$(BUILD_OS)-$(DIST)
endif

ifeq ($(filter $(OSDIST),$(DEBS) $(RPMS)),)
$(error $(OSDIST) does not exist in supported OS)
endif

ifeq ($(filter $(PACKAGE), $(SUPPORTED_PACKAGES)),)
$(error $(PACKAGE) does not exist in supported package types)
endif

ifneq ($(CLONE_BRANCH), $(STABLE_BRANCH))
PACKAGECLOUD_REPO=nightly
RELEASE:=$(NIGHTLY_BUILD_VERSION)
else
PACKAGECLOUD_REPO=stable
RELEASE:=$(STABLE_BUILD_VERSION)
endif

DOCKER_SUFFIX=
VENDOR_MK=$(filter $(REPO_VENDOR),$(SUPPORTED_VENDORS))

ifneq ($(filter $(VENDOR_MK),$(SUPPORTED_VENDORS)),)
include $(SCRIPTDIR)/builder/$(VENDOR_MK).mk
endif

ifneq ($(PHP_VERSION),)
ifneq ($(filter $(OSDIST),$(DEBS)),)
temp=$(RELEASE)
RELEASE:=$(temp)+php$(PHP_VERSION)
endif
endif

ifeq ($(PHP_VERSION),7.2)
ifneq (,$(filter $(DIST),stretch jessie trusty xenial))
DOCKER_SUFFIX=-7.2
endif
endif

REVISION=$(shell cd $(SOURCEDIR); git rev-parse --short=8 HEAD)
VERSION?=$(shell cat "$(SOURCEDIR)/config.json" | grep version | head -1 | sed -E 's|[\", ]||g' | cut -d ':' -f 2)
VERSION_FULL=$(VERSION)-$(RELEASE)-$(REVISION)
DOCKER_IMAGE=$(OSDIST)$(DOCKER_SUFFIX)
DOCKER_TAG=$(DOCKER_REPO):$(OSDIST)$(DOCKER_SUFFIX)
BUILDDIR=$(SCRIPTDIR)/build
TARBALL_EXTRA_ARGS=--exclude=.github --exclude=.editorconfig --exclude=.gitattributes
