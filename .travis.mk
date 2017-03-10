#!/usr/bin/make -f
# -*- makefile -*-
#
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

SHELL=/bin/bash
ZEPHIR=zephir
PHP=php
SCRIPTDIR:=${CURDIR}

# See https://github.com/packpack/packpack/pull/63
PACK_REPO=https://github.com/sergeyklay/build.git
PACK_BRANCH=patch-1

ZEND_BACKEND?=""

all: package

gen-build: check-env
ifneq ($(CLONE_BRANCH), $(STABLE_BRANCH))
	$(info Regenerate build...)
	cd $(PHALCON_DIR); \
	$(ZEPHIR) fullclean; \
	$(ZEPHIR) generate ${ZEND_BACKEND}; \
	$(PHP) build/gen-build.php
endif

check-env:
ifndef PHALCON_DIR
	$(error PHALCON_DIR is undefined)
endif
ifndef CLONE_BRANCH
	$(error CLONE_BRANCH is undefined)
endif
ifndef STABLE_BRANCH
	$(error STABLE_BRANCH is undefined)
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
	rm -rf $(SCRIPTDIR)/packpack

.ONESHELL:
.SECONDARY:
.PHONY: source package clean check-env gen-build
