#!/usr/bin/env bash

git clone https://github.com/phalcon/zephir.git /tmp/zephir && cd /tmp/zephir

ZEPHIRDIR="$( cd "$( dirname . )" && pwd )"
sed "s#%ZEPHIRDIR%#$ZEPHIRDIR#g" bin/zephir > bin/zephir-cmd
chmod 755 bin/zephir-cmd

mkdir -p ~/bin

cp bin/zephir-cmd ~/bin/zephir
rm bin/zephir-cmd
