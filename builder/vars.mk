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

gen-vars: get-info
	$(shell echo "#!/usr/bin/env bash" > $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export PRODUCT=\"$(PRODUCT)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export PRODUCT_EXTRA=\"$(PRODUCT_EXT'RA)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export PHALCON_DIR=\"$(PHALCON_DIR)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export BUILDDIR=\"$(BUILDDIR)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export SCRIPTDIR=\"$(SCRIPTDIR)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export STABLE_BRANCH=\"$(STABLE_BRANCH)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export NIGHTLY_BRANCH=\"$(NIGHTLY_BRANCH)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export NIGHTLY_BRANCH=\"$(NIGHTLY_BRANCH)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export CLONE_BRANCH=\"$(CLONE_BRANCH)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export RELEASE=\"$(RELEASE)\"" >> $(SCRIPTDIR)/.variables.sh)
	$(shell echo "export LAST_COMMIT=\"$(LAST_COMMIT)\"" >> $(SCRIPTDIR)/.variables.sh)
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
	@echo "   Full version name ..................: $(VERSION_FULL)"
	@echo ""
	@echo "   Travis PHP version .................: $(TRAVIS_PHP_VERSION)"
	@echo "   PHP major version ..................: $(PHP_MAJOR)"
	@echo "   Overrided PHP version ..............: $(PHP_VERSION)"
	@echo "   Zephir version .....................: $(ZEPHIR_VERSION)"
	@echo "   Zend Engine backend ................: $(ZEND_BACKEND)"
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
	@echo "   Changelog name .....................: $(CHANGELOG_NAME)"
	@echo "   Changelog email ....................: $(CHANGELOG_EMAIL)"
	@echo "   Changelog text .....................: $(CHANGELOG_TEXT)"
	@echo ""
	@echo ""
