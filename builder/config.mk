# This file is part of the Phalcon.
#
# (c) Phalcon Team <team@phalcon.io>
#
# For the full copyright and license information, please view
# the LICENSE.txt file that was distributed with this source code.
#
# If you did not receive a copy of the license it is available
# through the world-wide-web at the following url:
# https://license.phalcon.io

CHANGELOG_NAME=Phalcon Team
CHANGELOG_EMAIL=team@phalcon.io
CHANGELOG_TEXT=Automated build. See details at release page https://github.com/phalcon/cphalcon/releases

PACK_REPO=https://github.com/packpack/packpack.git
PACK_COMMIT=30ff7b51654c19b8919d01ca8d4aa480e87e8241

DOCKER_REPO=phalconphp/build

# Use -vv to display debugging information
RPMBUILD_FLAGS=-vv

PHP_VERSION?=
PHP_MAJOR=$(shell echo "$(PHP_VERSION)" | cut -d '.' -f 1,2)

ZEND_BACKEND?=
REPO_VENDOR?=
RELEASE=
PRODUCT?=php-phalcon

STABLE_BUILD_VERSION?=1
MAINLINE_BUILD_VERSION?=1
NIGHTLY_BUILD_VERSION?=1

# List of supported OS
FEDORA:=fedora-rawhide fedora24 fedora23
CENTOS:=centos7 centos6
DEBIAN:=debian-sid debian-buster debian-stretch debian-wheezy
UBUNTU:=ubuntu-bionic ubuntu-xenial ubuntu-trusty ubuntu-focal ubuntu-groovy

DEBS:=$(DEBIAN) $(UBUNTU)
RPMS:=$(FEDORA) $(CENTOS)

SUPPORTED_PACKAGES=rpm deb
SUPPORTED_VENDORS=ius

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

ifeq ($(CLONE_BRANCH), $(STABLE_BRANCH))
PACKAGECLOUD_REPO=$(PACKAGECLOUD_STABLE_REPO)
RELEASE:=$(STABLE_BUILD_VERSION)
else ifeq ($(CLONE_BRANCH), $(MAINLINE_BRANCH))
PACKAGECLOUD_REPO=$(PACKAGECLOUD_MAINLINE_REPO)
RELEASE:=$(MAINLINE_BUILD_VERSION)
else
PACKAGECLOUD_REPO=$(PACKAGECLOUD_NIGHTLY_REPO)
RELEASE:=$(NIGHTLY_BUILD_VERSION)
endif

DOCKER_SUFFIX=
VENDOR_MK=$(filter $(REPO_VENDOR),$(SUPPORTED_VENDORS))

ifneq ($(filter $(VENDOR_MK),$(SUPPORTED_VENDORS)),)
include $(SCRIPTDIR)/builder/$(VENDOR_MK).mk
endif

ifneq ($(PHP_VERSION),)
ifneq ($(filter $(OSDIST),$(DEBS)),)
temp=$(RELEASE)
RELEASE:=$(temp)-$(OSDIST)
endif
endif

ifeq ($(PHP_VERSION),7.0)
ifneq (,$(filter $(DIST),trusty))
DOCKER_SUFFIX=-7.0
endif
endif

ifeq ($(PHP_VERSION),7.1)
ifneq (,$(filter $(DIST),stretch trusty xenial))
DOCKER_SUFFIX=-7.1
endif
endif

ifeq ($(PHP_VERSION),7.2)
ifneq (,$(filter $(DIST),stretch trusty xenial focal groovy))
DOCKER_SUFFIX=-7.2
endif
endif

ifeq ($(PHP_VERSION),7.3)
ifneq (,$(filter $(DIST),buster stretch trusty xenial bionic focal groovy))
DOCKER_SUFFIX=-7.3
endif
endif

ifeq ($(PHP_VERSION),7.4)
ifneq (,$(filter $(DIST),buster stretch trusty xenial bionic focal groovy))
DOCKER_SUFFIX=-7.4
endif
endif

REVISION=$(shell cd $(SOURCEDIR); git rev-parse --short=8 HEAD)
ifeq (el,$(OS))
VERSION?=$(shell cat "$(SOURCEDIR)/config.json" | grep version | head -1 | sed -E 's|[\", ]||g' | cut -d ':' -f 2 | tr -s '-' | tr '-' '_')
else
VERSION?=$(shell cat "$(SOURCEDIR)/config.json" | grep version | head -1 | sed -E 's|[\", ]||g' | cut -d ':' -f 2)
endif
VERSION_FULL=$(VERSION)-$(RELEASE)-$(REVISION)
DOCKER_IMAGE=$(OSDIST)$(DOCKER_SUFFIX)
DOCKER_TAG=$(DOCKER_REPO):$(OSDIST)$(DOCKER_SUFFIX)
BUILDDIR=$(SCRIPTDIR)/build
TARBALL_EXTRA_ARGS=--exclude=.github --exclude=.editorconfig --exclude=.gitattributes
