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

# Enable this for debugging the sed scripts
SED=$(SCRIPTDIR)/sedsed

.NOTPARALLEL: ; # wait for this target to finish

include $(SCRIPTDIR)/builder/functions.mk
include $(SCRIPTDIR)/builder/config.mk
include $(SCRIPTDIR)/builder/check.mk
include $(SCRIPTDIR)/builder/vars.mk

gen-build:
ifneq ($(CLONE_BRANCH), $(STABLE_BRANCH))
	$(info Regenerate build...)
	cd $(PHALCON_DIR); \
	$(ZEPHIR) fullclean; \
	$(ZEPHIR) generate ${ZEND_BACKEND}; \
	$(PHP) build/gen-build.php
endif

source: gen-build
	$(info Create tarball...)
	git clone -q --depth=1 $(PACK_REPO) -b $(PACK_BRANCH) $(SCRIPTDIR)/packpack
	TARBALL_COMPRESSOR=gz packpack/packpack tarball

package: gen-build
	$(info Build package...)
	git clone -q --depth=1 $(PACK_REPO) -b $(PACK_BRANCH) $(SCRIPTDIR)/packpack
	./packpack/packpack

clean:
	$(info Clenup...)
	rm -rf $(SCRIPTDIR)/packpack $(SCRIPTDIR)/.variables.sh; \
	cd $(PHALCON_DIR); \
	$(ZEPHIR) fullclean; \
	git checkout --
