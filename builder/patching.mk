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

DEB_SPEC=$(SCRIPTDIR)/debian/rules

RPM_SPEC=$(SCRIPTDIR)/rpm/php-phalcon.spec
RPM_PRODUCT=
RPM_PHP_BASE=

PHALCON_HEADERS=$(shell grep -r -l "^void zephir_init_static_properties_Phalcon_Tag" $(SOURCEDIR)/build | grep phalcon.zep.h)

ifneq ($(PRODUCT_EXTRA),)
RPM_PRODUCT:=$(PRODUCT_EXTRA)
else ifneq ($(PRODUCT),)
RPM_PRODUCT:=$(PRODUCT)
else
RPM_PRODUCT:=php-phalcon
endif

ifneq ($(PHP_VERSION),)
RPM_PHP_BASE:=$(PHP_VERSION)
else
RPM_PHP_BASE:=php
endif

define patching_rpmspec
	cp $(1) rpmspec.tmp
	sed \
		-e 's/Name:\([\ \t]*\)%{php_base}-phalcon/Name: $(RPM_PRODUCT)/' \
		-e 's/%global\([\ \t]*\)php_base\([\ \t]*\).*/%global php_base $(RPM_PHP_BASE)/' \
		-e 's/%global\([\ \t]*\)repo_vendor\([\ \t]*\).*/%global repo_vendor $(REPO_VENDOR)/' \
		-i rpmspec.tmp
	grep -F "Name: $(RPM_PRODUCT)" rpmspec.tmp && \
		grep -F "php_base $(RPM_PHP_BASE)" rpmspec.tmp && \
		grep -F "repo_vendor $(REPO_VENDOR)" rpmspec.tmp || \
		(echo "Failed to patch $(1)" && exit 1)
	mkdir -p $(SOURCEDIR)/rpm
	mv -f rpmspec.tmp $(SOURCEDIR)/rpm/php-phalcon.spec
endef

define patching_init_static_properties
	echo "-------------------------------------------------------------------"
	echo "Patching $(1)"
	echo "-------------------------------------------------------------------"
	cp $(1) $@.tmp
	sed \
		-e 's/void zephir_init_static_properties_Phalcon_Tag/static void zephir_init_static_properties_Phalcon_Tag/' \
		-i $@.tmp
	grep -F "static void zephir_init_static_properties_Phalcon_Tag" $@.tmp || \
		(echo "Failed to patch $(1)" && exit 1)
	mv -f $@.tmp $(1)
	echo
endef

patching-headers: $(PHALCON_HEADERS)
	$(info -------------------------------------------------------------------)
	$(info Scan for $(PHALCON_HEADERS))
	$(info -------------------------------------------------------------------)
	$(foreach file,$(PHALCON_HEADERS),$(call patching_init_static_properties,$(file));)
	$(info )

prepare-build: prepare-$(PACKAGE)-spec
	$(info -------------------------------------------------------------------)
	$(info Prepare .build.mk)
	$(info -------------------------------------------------------------------)
	@cp $(SCRIPTDIR)/build.tpl $@.tmp
ifneq ($(REPO_VENDOR),)
	@echo "RELEASE=$(RELEASE).$(REPO_VENDOR)" >> $@.tmp
endif
	@mv -f $@.tmp $(SOURCEDIR)/.build.mk
	$(info )

prepare-deb-spec: $(DEB_SPEC)
	$(info -------------------------------------------------------------------)
	$(info Patching $<)
	$(info -------------------------------------------------------------------)
	@cp $< $@.tmp
	@cp -r $(SCRIPTDIR)/debian $(SOURCEDIR)/debian
	@mv -f $@.tmp $(SOURCEDIR)/debian/rules
	$(info )

prepare-rpm-spec: $(RPM_SPEC)
	$(info -------------------------------------------------------------------)
	$(info Patching $<)
	$(info -------------------------------------------------------------------)
	$(call patching_rpmspec,$<)
	$(info )
