#!/usr/bin/make -f
# -*- makefile -*-
#
# This file is part of the Phalcon Builder.
#
# (c) Phalcon Team <team@phalcon.io>
#
# For the full copyright and license information, please view
# the LICENSE file that was distributed with this source code.
#
# If you did not receive a copy of the license it is available
# through the world-wide-web at the following url:
# https://license.phalcon.io

SHELL := $(shell which bash)
SCRIPTDIR := ${CURDIR}
D_TARGETS = report prepare-build

.EXPORT_ALL_VARIABLES: ; # send all vars to shell

include $(SCRIPTDIR)/builder/config.mk
include $(SCRIPTDIR)/builder/check.mk
include $(SCRIPTDIR)/builder/patching.mk

$(SCRIPTDIR)/packpack:
	$(shell git clone $(PACK_REPO) $(SCRIPTDIR)/packpack)
	$(shell cd $(SCRIPTDIR)/packpack && git checkout -qf $(PACK_COMMIT))
	$(info -------------------------------------------------------------------)
	$(info Patching packpak...)
	$(shell cd $(SCRIPTDIR)/packpack && git apply $(SCRIPTDIR)/gh-84.patch)
	$(shell cd $(SCRIPTDIR)/packpack && git apply $(SCRIPTDIR)/gh-97.patch)

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
	$(info )
	$(info Source path ........................: $(SOURCEDIR))
	$(info Build path .........................: $(BUILDDIR))
	$(info Current path .......................: $(SCRIPTDIR))
	$(info )
	$(info Stable branch/tag ..................: $(STABLE_BRANCH))
	$(info Mainline branch/tag ................: $(MAINLINE_BRANCH))
	$(info Nightly branch/tag .................: $(NIGHTLY_BRANCH))
	$(info Current working branch/tag .........: $(CLONE_BRANCH))
	$(info Travis build number ................: $(TRAVIS_BUILD_NUMBER))
	$(info )
	$(info Zephir version .....................: $(ZEPHIR_VERSION))
	$(info Zephir Parser version ..............: $(ZEPHIR_PARSER_VERSION))
	$(info )
	$(info Build release ......................: $(RELEASE))
	$(info Revision ...........................: $(REVISION))
	$(info Semantic version: ..................: $(VERSION))
	$(info Full version name ..................: $(VERSION_FULL))
	$(info )
	$(info Used PHP version ...................: $(PHP_VERSION))
	$(info PHP major version ..................: $(PHP_MAJOR))
	$(info PHP full version ...................: $(PHP_FULL_VERSION))
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
