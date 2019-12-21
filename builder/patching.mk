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


DEB_SPEC=$(SCRIPTDIR)/debian/rules

RPM_SPEC=$(SCRIPTDIR)/rpm/php-phalcon.spec
RPM_PRODUCT=

.PHONY: prepare-build
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

.PHONY: prepare-deb-spec
prepare-deb-spec: $(DEB_SPEC)
	$(info -------------------------------------------------------------------)
	$(info Patching $<)
	$(info -------------------------------------------------------------------)
	@cp $< $@.tmp
	@cp -r $(SCRIPTDIR)/debian $(SOURCEDIR)/debian
	@mv -f $@.tmp $(SOURCEDIR)/debian/rules
	$(info )

.PHONY: prepare-rpm-spec
prepare-rpm-spec: $(RPM_SPEC)
	$(info -------------------------------------------------------------------)
	$(info Prepare $<)
	$(info -------------------------------------------------------------------)
	@mkdir -p $(SOURCEDIR)/rpm
	@cp -f $< $(SOURCEDIR)/rpm/php-phalcon.spec
	$(info )
