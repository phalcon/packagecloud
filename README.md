# Phalcon Build Project

[![Build Status](https://travis-ci.org/phalcongelist/packagecloud.svg?branch=master)][:build-st:]

Phalcon is an open source web framework delivered as a C extension for the PHP language
providing high performance and lower resource consumption.

## Installation Instructions

Phalcon distribution is hosted at [PackageCloud][:cloud:].
Stable versions correspond to Phalcon release tags and should be used in production.
Nightly versions are built daily and should **not** be used in production.
Installation/configuration details for each version and operating system [can be found below](#add-new-package-repository):

## Supported Operating Systems

### Ubuntu

| Codename  | OS Release | Phalcon Releases  | Supported PHP versions |
| --------- | ---------- | ----------------- | ---------------------- |
| `trusty`  | 14.04 LTS  | `3.0.0` - `3.0.2` | `5.5.x`, `7.0.x`       |
| `wily`    | 15.10      | `3.0.0` - `3.0.2` | `5.6.x`                |
| `xenial`  | 16.04 LTS  | `3.0.0` - `3.0.2` | `7.0.x`                |

### Debian

| Codename  | OS Release | Phalcon Releases  | Supported PHP versions |
| --------- | ---------- | ----------------- | ---------------------- |
| `jessie`  | 8.5 LTS    | `3.0.0` - `3.0.2` | `5.6.x`                |
| `jessie`  | 8.5 LTS    | `3.0.1` - `3.0.2` | `7.0.x`                |
| `stretch` | 9          | `3.0.0` - `3.0.2` | `7.0.x`                |

### CentOS (RHEL)

| Codename  | OS Release | Phalcon Releases  | Supported PHP versions | PHP repository |
| --------- | ---------- | ----------------- | ---------------------- | -------------- |
| `Core`    | 7.2 LTS    | `3.0.1` - `3.0.2` | `php56u`               | `IUS`          |

### Fedora

_Coming Soon_

## Add new package repository

### DEB packages

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
# PHP 5
sudo apt-get install php5-phalcon

# PHP 7
sudo apt-get install php7.0-phalcon
```

### RPM packages

```sh
# PHP 5

# IUS repository
sudo yum install php56u-phalcon
```

## Download packages manually

* Packages for [stable version][:stable:]
* Packages for [nightly version][:nightly:]

## License

Phalcon is open source software licensed under the New BSD License.<br>
See the https://www.phalconphp.com/LICENSE.txt file for more.

[:build-st:]: https://travis-ci.org/phalcongelist/packagecloud
[:cloud:]: https://packagecloud.io/phalcon
[:stable:]: https://packagecloud.io/phalcon/stable
[:nightly:]: https://packagecloud.io/phalcon/nightly
