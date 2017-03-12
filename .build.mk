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

$(info We are here)

REPO_VENDOR ?=

$(BUILDDIR)/$(RPMSPEC): $(RPMSPECIN)
	@echo "-------------------------------------------------------------------"
	@echo "Custom patching RPM spec"
	@echo "-------------------------------------------------------------------"
	@cp $< $@.tmp
	sed \
		-e 's/Version:\([ ]*\).*/Version: $(VERSION)/' \
		-e 's/Release:\([ ]*\).*/Release: $(RELEASE)$(REPO_VENDOR)%{dist}/' \
		-e 's/Source0:\([ ]*\).*/Source0: $(TARBALL)/' \
		-e 's/%setup.*/%setup -q -n $(PRODUCT)-$(VERSION)/' \
		-e '0,/%autosetup.*/ s/%autosetup.*/%autosetup -n $(PRODUCT)-$(VERSION)/' \
		-i $@.tmp
	grep -F "Version: $(VERSION)" $@.tmp && \
		grep -F "Release: $(RELEASE)" $@.tmp && \
		grep -F "Source0: $(TARBALL)" $@.tmp && \
		(grep -F "%setup -q -n $(PRODUCT)-$(VERSION)" $@.tmp || \
		grep -F "%autosetup" $@.tmp) || \
		(echo "Failed to patch RPM spec" && exit 1)
	@ mv -f $@.tmp $@
	@echo
