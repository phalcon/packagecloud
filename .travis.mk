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

SCRIPTDIR:=${CURDIR}

all: package

source:
	# See https://github.com/packpack/packpack/pull/63
	git clone https://github.com/packpack/packpack.git sergeyklay/build.git -b patch-1 $(SCRIPTDIR)/packpack
	TARBALL_COMPRESSOR=gz packpack/packpack tarball

package:
	# See https://github.com/packpack/packpack/pull/63
	git clone https://github.com/packpack/packpack.git sergeyklay/build.git -b patch-1 $(SCRIPTDIR)/packpack
	./packpack/packpack

clean:
	rm -rf $(SCRIPTDIR)/packpack

.SECONDARY:
.PHONY: clean
