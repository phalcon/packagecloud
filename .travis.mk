#!/usr/bin/make -f
# -*- makefile -*-
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

SHELL:=$(shell which bash)
SCRIPTDIR:=${CURDIR}
D_TARGETS=gen-docker-vars patching-rpm patching-deb patching-headers report copying-build

.EXPORT_ALL_VARIABLES: ; # send all vars to shell

.PHONY: source package $(D_TARGETS)

include $(SCRIPTDIR)/builder/config.mk
include $(SCRIPTDIR)/builder/check.mk
include $(SCRIPTDIR)/builder/vars.mk
include $(SCRIPTDIR)/builder/patching.mk

source: $(D_TARGETS)
	$(info Create tarball...)
	git clone -q --depth=1 $(PACK_REPO) -b $(PACK_BRANCH) $(SCRIPTDIR)/packpack
	TARBALL_COMPRESSOR=gz $(SCRIPTDIR)/packpack/packpack tarball

package: $(D_TARGETS)
	$(info Build package...)
	git clone -q --depth=1 $(PACK_REPO) -b $(PACK_BRANCH) $(SCRIPTDIR)/packpack
	$(SCRIPTDIR)/packpack/packpack
