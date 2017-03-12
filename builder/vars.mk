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

gen-docker-vars:
	$(shell echo "PRODUCT_EXTRA=$(PRODUCT_EXTRA)" > $(BUILDDIR)/env)
	$(shell echo "TRAVIS_PHP_VERSION=$(TRAVIS_PHP_VERSION)" >> $(BUILDDIR)/env)
	$(shell echo "PHP_VERSION=$(PHP_VERSION)" >> $(BUILDDIR)/env)
	$(shell echo "REPO_VENDOR=$(REPO_VENDOR)" >> $(BUILDDIR)/env)

report:
	@echo ""
	@echo ""
	@echo "   Product ............................: $(PRODUCT)"
	@echo "   Product extra ......................: $(PRODUCT_EXTRA)"
	@echo ""
	@echo "   Source path ........................: $(SOURCEDIR)"
	@echo "   Build path .........................: $(BUILDDIR)"
	@echo "   Current path .......................: $(SCRIPTDIR)"
	@echo ""
	@echo "   Stable branch/tag ..................: $(STABLE_BRANCH)"
	@echo "   Nightly branch/tag .................: $(NIGHTLY_BRANCH)"
	@echo "   Clone branch/tag ...................: $(CLONE_BRANCH)"
	@echo ""
	@echo "   Build release ......................: $(RELEASE)"
	@echo "   Revision ...........................: $(REVISION)"
	@echo "   Semantic version: ..................: $(VERSION)"
	@echo "   Full version name ..................: $(VERSION_FULL)"
	@echo ""
	@echo "   Travis PHP version .................: $(TRAVIS_PHP_VERSION)"
	@echo "   PHP major version ..................: $(PHP_MAJOR)"
	@echo "   Overrided PHP version ..............: $(PHP_VERSION)"
	@echo "   Zend Engine backend ................: $(ZEND_BACKEND)"
	@echo ""
	@echo "   Repo vendor ........................: $(REPO_VENDOR)"
	@echo "   OS .................................: $(OS)"
	@echo "   Build OS ...........................: $(BUILD_OS)"
	@echo "   Distrib. version ...................: $(DIST)"
	@echo ""
	@echo "   Packagecloud repo ..................: $(PACKAGECLOUD_REPO)"
	@echo "   Packagecloud user ..................: $(PACKAGECLOUD_USER)"
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
