# Phalcon Package Builder

[![Build Status](https://travis-ci.org/phalcongelist/packagecloud.svg?branch=master)][:build-st:]

Phalcon is an open source web framework delivered as a C extension for the PHP language
providing high performance and lower resource consumption.

## Installation Instructions

Phalcon distribution is hosted at [PackageCloud][:cloud:].
Stable versions correspond to Phalcon release tags and should be used in production.
Nightly versions are built daily and should **not** be used in production.
Installation/configuration details for each version and operating system [can be found below](#add-new-package-repository):

## Supported Operating Systems

- Ubuntu 14.04 LTS (Trusty)
- Ubuntu 16.04 LTS (Xenial)
- Ubuntu 18.04 LTS (Bionic)
- Debian 8.5 LTS (Jessie)
- Debian 9 LTS (Stretch)
- CentOS 7.2 LTS (Core)

```sh
# Stable releases
curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | sudo bash

# Nightly releases
curl -s https://packagecloud.io/install/repositories/phalcon/nightly/script.deb.sh | sudo bash
```

### RPM packages

```sh
# Stable releases
curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.rpm.sh | sudo bash

# Nightly releases
curl -s https://packagecloud.io/install/repositories/phalcon/nightly/script.rpm.sh | sudo bash
```

## Installation

### DEB packages

```sh
# PHP 7.2
sudo apt-get install php7.2-phalcon
```

### RPM packages

```sh
# PHP 7.2
sudo yum install php72u-phalcon
```

## Download packages manually

* Packages for [stable version][:stable:]
* Packages for [nightly version][:nightly:]

## License

This work licensed under the BSD 3-Clause License.<br>
Copyright © 2011-present, Phalcon Team.<br>
See the [LICENSE.txt](https://github.com/phalcongelist/packagecloud/blob/master/LICENSE.txt) file for more.

[:build-st:]: https://travis-ci.org/phalcongelist/packagecloud
[:cloud:]: https://packagecloud.io/phalcon
[:stable:]: https://packagecloud.io/phalcon/stable
[:nightly:]: https://packagecloud.io/phalcon/nightly
[:ius:]: https://github.com/iuscommunity-pkg
