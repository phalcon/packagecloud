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

gen-host-vars: get-info
	$(shell echo "#!/usr/bin/env bash" > $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export PRODUCT=\"$(PRODUCT)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export PRODUCT_EXTRA=\"$(PRODUCT_EXTRA)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export PHALCON_DIR=\"$(PHALCON_DIR)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export BUILDDIR=\"$(BUILDDIR)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export SCRIPTDIR=\"$(SCRIPTDIR)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export STABLE_BRANCH=\"$(STABLE_BRANCH)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export NIGHTLY_BRANCH=\"$(NIGHTLY_BRANCH)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export NIGHTLY_BRANCH=\"$(NIGHTLY_BRANCH)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export CLONE_BRANCH=\"$(CLONE_BRANCH)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export RELEASE=\"$(RELEASE)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export REVISION=\"$(REVISION)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export VERSION=\"$(VERSION)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export VERSION_FULL=\"$(VERSION_FULL)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export TRAVIS_PHP_VERSION=\"$(TRAVIS_PHP_VERSION)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export PHP_MAJOR=\"$(PHP_MAJOR)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export PHP_VERSION=\"$(PHP_VERSION)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export ZEPHIR_VERSION=\"$(ZEPHIR_VERSION)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export ZEND_BACKEND=\"$(ZEND_BACKEND)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export REPO_VENDOR=\"$(REPO_VENDOR)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export OS=\"$(OS)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export BUILD_OS=\"$(BUILD_OS)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export DIST=\"$(DIST)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export PACKAGECLOUD_REPO=\"$(PACKAGECLOUD_REPO)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export DOCKER_REPO=\"$(DOCKER_REPO)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export DOCKER_IMAGE=\"$(DOCKER_IMAGE)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export DOCKER_SUFFIX=\"$(DOCKER_SUFFIX)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export DOCKER_TAG=\"$(DOCKER_TAG)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export PACKAGE=\"$(PACKAGE)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export CHANGELOG_NAME=\"$(CHANGELOG_NAME)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export CHANGELOG_EMAIL=\"$(CHANGELOG_EMAIL)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export CHANGELOG_TEXT=\"$(CHANGELOG_TEXT)\"" >> $(SCRIPTDIR)/.variables.sh)

gen-docker-vars:
	$(shell echo "PRODUCT_EXTRA=$(PRODUCT_EXTRA)" > $(BUILDDIR)/env)
	$(shell echo "PHP_VERSION=$(PHP_VERSION)" >> $(BUILDDIR)/env)
	$(shell echo "REPO_VENDOR=$(REPO_VENDOR)" >> $(BUILDDIR)/env)

get-info:
	@echo ""
	@echo ""
	@echo "   Product ............................: $(OK_COLOR)$(PRODUCT)$(NO_COLOR)"
	@echo "   Product extra ......................: $(OK_COLOR)$(PRODUCT_EXTRA)$(NO_COLOR)"
	@echo ""
	@echo "   Product path .......................: $(OK_COLOR)$(PHALCON_DIR)$(NO_COLOR)"
	@echo "   Build path .........................: $(OK_COLOR)$(BUILDDIR)$(NO_COLOR)"
	@echo "   Current path .......................: $(OK_COLOR)$(SCRIPTDIR)$(NO_COLOR)"
	@echo ""
	@echo "   Stable branch/tag ..................: $(OK_COLOR)$(STABLE_BRANCH)$(NO_COLOR)"
	@echo "   Nightly branch/tag .................: $(OK_COLOR)$(NIGHTLY_BRANCH)$(NO_COLOR)"
	@echo "   Clone branch/tag ...................: $(OK_COLOR)$(CLONE_BRANCH)$(NO_COLOR)"
	@echo ""
	@echo "   Build release ......................: $(OK_COLOR)$(RELEASE)$(NO_COLOR)"
	@echo "   Revision ...........................: $(OK_COLOR)$(REVISION)$(NO_COLOR)"
	@echo "   Semantic version: ..................: $(OK_COLOR)$(VERSION)$(NO_COLOR)"
	@echo "   Full version name ..................: $(OK_COLOR)$(VERSION_FULL)$(NO_COLOR)"
	@echo ""
	@echo "   Travis PHP version .................: $(OK_COLOR)$(TRAVIS_PHP_VERSION)$(NO_COLOR)"
	@echo "   PHP major version ..................: $(OK_COLOR)$(PHP_MAJOR)$(NO_COLOR)"
	@echo "   Overrided PHP version ..............: $(OK_COLOR)$(PHP_VERSION)$(NO_COLOR)"
	@echo "   Zephir version .....................: $(OK_COLOR)$(ZEPHIR_VERSION)$(NO_COLOR)"
	@echo "   Zend Engine backend ................: $(OK_COLOR)$(ZEND_BACKEND)$(NO_COLOR)"
	@echo ""
	@echo "   Repo vendor ........................: $(OK_COLOR)$(REPO_VENDOR)$(NO_COLOR)"
	@echo "   OS .................................: $(OK_COLOR)$(OS)$(NO_COLOR)"
	@echo "   Build OS ...........................: $(OK_COLOR)$(BUILD_OS)$(NO_COLOR)"
	@echo "   Distrib. version ...................: $(OK_COLOR)$(DIST)$(NO_COLOR)"
	@echo ""
	@echo "   Packagecloud repo ..................: $(OK_COLOR)$(PACKAGECLOUD_REPO)$(NO_COLOR)"
	@echo "   Docker repo ........................: $(OK_COLOR)$(DOCKER_REPO)$(NO_COLOR)"
	@echo "   Docker image .......................: $(OK_COLOR)$(DOCKER_IMAGE)$(NO_COLOR)"
	@echo "   Docker suffix ......................: $(OK_COLOR)$(DOCKER_SUFFIX)$(NO_COLOR)"
	@echo "   Fully qualified Docker image .......: $(OK_COLOR)$(DOCKER_TAG)$(NO_COLOR)"
	@echo "   Package type .......................: $(OK_COLOR)$(PACKAGE)$(NO_COLOR)"
	@echo ""
	@echo "   Changelog name .....................: $(OK_COLOR)$(CHANGELOG_NAME)$(NO_COLOR)"
	@echo "   Changelog email ....................: $(OK_COLOR)$(CHANGELOG_EMAIL)$(NO_COLOR)"
	@echo "   Changelog text .....................: $(OK_COLOR)$(CHANGELOG_TEXT)$(NO_COLOR)"
	@echo ""
	@echo ""
