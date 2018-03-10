#!/usr/bin/make -f
# -*- makefile -*-
#
# Phalcon Build Project
#
# Copyright (c) 2011-present, Phalcon Team (https://www.phalconphp.com)
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

SHELL := $(shell which bash)
SCRIPTDIR := ${CURDIR}
D_TARGETS = report prepare-build

.EXPORT_ALL_VARIABLES: ; # send all vars to shell

include $(SCRIPTDIR)/builder/config.mk
include $(SCRIPTDIR)/builder/check.mk
include $(SCRIPTDIR)/builder/patching.mk

$(SCRIPTDIR)/packpack:
	$(shell git clone -q --depth=1 $(PACK_REPO) -b $(PACK_BRANCH) $(SCRIPTDIR)/packpack)
	$(info -------------------------------------------------------------------)
	$(info Patching packpak...)
	$(shell cd $(SCRIPTDIR)/packpack && git apply $(SCRIPTDIR)/gh-84.diff)

.PHONY: source
source: $(D_TARGETS) $(SCRIPTDIR)/packpack
	$(info Create tarball...)
	TARBALL_COMPRESSOR=gz $(SCRIPTDIR)/packpack/packpack tarball

.PHONY: package
package: $(D_TARGETS) $(SCRIPTDIR)/packpack
	$(info Build package...)
	$(SCRIPTDIR)/packpack/packpack

.PHONY: report
report:
	$(info )
	$(info Product ............................: $(PRODUCT))
	$(info Product extra ......................: $(PRODUCT_EXTRA))
	$(info )
	$(info Source path ........................: $(SOURCEDIR))
	$(info Build path .........................: $(BUILDDIR))
	$(info Current path .......................: $(SCRIPTDIR))
	$(info )
	$(info Stable branch/tag ..................: $(STABLE_BRANCH))
	$(info Nightly branch/tag .................: $(NIGHTLY_BRANCH))
	$(info Current working branch/tag .........: $(CLONE_BRANCH))
	$(info Travis build number ................: $(TRAVIS_BUILD_NUMBER))
	$(info )
	$(info Build release ......................: $(RELEASE))
	$(info Revision ...........................: $(REVISION))
	$(info Semantic version: ..................: $(VERSION))
	$(info Full version name ..................: $(VERSION_FULL))
	$(info )
	$(info Travis PHP version .................: $(TRAVIS_PHP_VERSION))
	$(info PHP major version ..................: $(PHP_MAJOR))
	$(info Overrided PHP version ..............: $(PHP_VERSION))
	$(info Zend Engine backend ................: $(ZEND_BACKEND))
	$(info )
	$(info Repo vendor ........................: $(REPO_VENDOR))
	$(info OS .................................: $(OS))
	$(info Build OS ...........................: $(BUILD_OS))
	$(info Distrib. version ...................: $(DIST))
	$(info )
	$(info Packagecloud repo ..................: $(PACKAGECLOUD_REPO))
	$(info Packagecloud user ..................: $(PACKAGECLOUD_USER))
	$(info Docker repo ........................: $(DOCKER_REPO))
	$(info Docker image .......................: $(DOCKER_IMAGE))
	$(info Docker suffix ......................: $(DOCKER_SUFFIX))
	$(info Fully qualified Docker image .......: $(DOCKER_TAG))
	$(info Package type .......................: $(PACKAGE))
	$(info Packaging target ...................: $(TARGET))
	$(info )
	$(info Changelog name .....................: $(CHANGELOG_NAME))
	$(info Changelog email ....................: $(CHANGELOG_EMAIL))
	$(info Changelog text .....................: $(CHANGELOG_TEXT))
	$(info )
