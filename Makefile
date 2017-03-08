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
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
ARGS=$(filter-out $@,$(MAKECMDGOALS))

.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.EXPORT_ALL_VARIABLES: ; # send all vars to shell

all: check

# Sanity checks
check:
ifneq ($(wildcard ~/cphalcon/.*),)
	$(info Found Phalcon source dir)
else
	$(error Phalcon source dir does not exists)
endif
ifeq ("$(wildcard VERSION)","")
$(error Missing VERSION file)
endif
	docker pull $(DOCKER_TAG)

centos7: check
	$(info Hello world)
	exit 0

clean:

.SECONDARY: # no target is removed because it is considered intermediate
.PHONY: clean
