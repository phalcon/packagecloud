# Phalcon Build Project

[![Build Status](https://travis-ci.org/phalcongelist/packagecloud.svg?branch=master)][:build-st:]

## Installation Instructions

Phalcon distribution is hosted at [PackageCloud][:cloud:].
Stable versions correspond to Phalcon release tags and should be used in production.
Nightly versions are built daily and should **not** be used in production.
Installation/configuration details for each version and operating system [can be found below](#add-new-package-repository):

## Supported Operating Systems

### Ubuntu

| Codename  | OS Release | Phalcon Releases  | Supported PHP versions |
| --------- | ---------- | ----------------- | ---------------------- |
| `trusty`  | 14.04 LTS  | `3.0.0` - `3.0.1` | `5.5.x`, `7.0.x`       |
| `wily`    | 15.10      | `3.0.0` - `3.0.1` | `5.6.x`                |
| `xenial`  | 16.04 LTS  | `3.0.0` - `3.0.1` | `7.0.x`                |

### Debian

| Codename  | OS Release | Phalcon Releases  | Supported PHP versions |
| --------- | ---------- | ----------------- | ---------------------- |
| `jessie`  | 8.5 LTS    | `3.0.0` - `3.0.1` | `5.6.x`                |
| `stretch` | 9          | `3.0.0` - `3.0.1` | `7.0.x`                |

### CentOS (RHEL)

_Coming Soon_

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

## Installation

### DEB packages

**PHP 5**

```sh
sudo apt-get install php5-phalcon
```

**PHP 7**

```
sudo apt-get install php7.0-phalcon
```

## Download packages manually

* Packages for [stable version][:stable:]
* Packages for [nightly version][:nightly:]

## License

Phalcon is open source software licensed under the New BSD License.<br>
See the [docs/LICENSE.txt][:docs:] file for more.

[:build-st:]: https://travis-ci.org/phalcongelist/packagecloud
[:cloud:]: https://packagecloud.io/phalcon
[:stable:]: https://packagecloud.io/phalcon/stable
[:nightly:]: https://packagecloud.io/phalcon/nightly
[:docs:]: https://github.com/phalcongelist/packagecloud/blob/master/docs/LICENSE.txt
