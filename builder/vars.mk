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
	@echo "   Product ............................: $(GREEN)$(PRODUCT)$(NC)"
	@echo "   Product extra ......................: $(GREEN)$(PRODUCT_EXTRA)$(NC)"
	@echo ""
	@echo "   Product path .......................: $(GREEN)$(PHALCON_DIR)$(NC)"
	@echo "   Build path .........................: $(GREEN)$(BUILDDIR)$(NC)"
	@echo "   Current path .......................: $(GREEN)$(SCRIPTDIR)$(NC)"
	@echo ""
	@echo "   Stable branch/tag ..................: $(GREEN)$(STABLE_BRANCH)$(NC)"
	@echo "   Nightly branch/tag .................: $(GREEN)$(NIGHTLY_BRANCH)$(NC)"
	@echo "   Clone branch/tag ...................: $(GREEN)$(CLONE_BRANCH)$(NC)"
	@echo ""
	@echo "   Build release ......................: $(GREEN)$(RELEASE)$(NC)"
	@echo "   Revision ...........................: $(GREEN)$(REVISION)$(NC)"
	@echo "   Semantic version: ..................: $(GREEN)$(VERSION)$(NC)"
	@echo "   Full version name ..................: $(GREEN)$(VERSION_FULL)$(NC)"
	@echo ""
	@echo "   Travis PHP version .................: $(GREEN)$(TRAVIS_PHP_VERSION)$(NC)"
	@echo "   PHP major version ..................: $(GREEN)$(PHP_MAJOR)$(NC)"
	@echo "   Overrided PHP version ..............: $(GREEN)$(PHP_VERSION)$(NC)"
	@echo "   Zephir version .....................: $(GREEN)$(ZEPHIR_VERSION)$(NC)"
	@echo "   Zend Engine backend ................: $(GREEN)$(ZEND_BACKEND)$(NC)"
	@echo ""
	@echo "   Repo vendor ........................: $(GREEN)$(REPO_VENDOR)$(NC)"
	@echo "   OS .................................: $(GREEN)$(OS)$(NC)"
	@echo "   Build OS ...........................: $(GREEN)$(BUILD_OS)$(NC)"
	@echo "   Distrib. version ...................: $(GREEN)$(DIST)$(NC)"
	@echo ""
	@echo "   Packagecloud repo ..................: $(GREEN)$(PACKAGECLOUD_REPO)$(NC)"
	@echo "   Docker repo ........................: $(GREEN)$(DOCKER_REPO)$(NC)"
	@echo "   Docker image .......................: $(GREEN)$(DOCKER_IMAGE)$(NC)"
	@echo "   Docker suffix ......................: $(GREEN)$(DOCKER_SUFFIX)$(NC)"
	@echo "   Fully qualified Docker image .......: $(GREEN)$(DOCKER_TAG)$(NC)"
	@echo "   Package type .......................: $(GREEN)$(PACKAGE)$(NC)"
	@echo ""
	@echo "   Changelog name .....................: $(GREEN)$(CHANGELOG_NAME)$(NC)"
	@echo "   Changelog email ....................: $(GREEN)$(CHANGELOG_EMAIL)$(NC)"
	@echo "   Changelog text .....................: $(GREEN)$(CHANGELOG_TEXT)$(NC)"
	@echo ""
	@echo ""
