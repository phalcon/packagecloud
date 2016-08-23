# Phalcon Build Project

[![Build Status](https://travis-ci.org/phalcongelist/packagecloud.svg?branch=master)][:build-st:]

## Installation Instructions

Phalcon distribution is hosted at [PackageCloud][:cloud:].
Stable versions correspond to Phalcon release tags and should be used in production.
Nightly versions are built daily and should **not** be used in production.
Installation/configuration details for each version and operating system [can be found below](#add-new-package-repository):

## Supported Operating Systems

### Ubuntu

| Codename  | OS Release | Phalcon Releases  | PHP version  | Docker image                                        |
| --------- | ---------- | ----------------- | ------------ | --------------------------------------------------- |
| `trusty`  | 14.04 LTS  | `3.0.0` - `3.0.1` | `5.5.x`      | [`phalconphp/build:ubuntu-trusty`][:ubuntu-trusty:] |
| `trusty`  | 14.04 LTS  | `3.0.0` - `3.0.1` | `7.0.x`      | [`phalconphp/build:ubuntu-trusty-7.0`][:trusty-7:]  |
| `wily`    | 15.10      | `3.0.0` - `3.0.1` | `5.6.x`      | [`phalconphp/build:ubuntu-wily`][:ubuntu-wily:]     |
| `xenial`  | 16.04 LTS  | `3.0.0` - `3.0.1` | `7.0.x`      | [`phalconphp/build:ubuntu-xenial`][:ubuntu-xenial:] |

### Debian

| Codename  | OS Release | Phalcon Releases  | PHP version  | Docker image                                          |
| --------- | ---------- | ----------------- | ------------ | ----------------------------------------------------- |
| `jessie`  | 8.5 LTS    | `3.0.0` - `3.0.1` | `5.6.x`      | [`phalconphp/build:debian-jessie`][:debian-jessie:]   |
| `stretch` | 9          | `3.0.0` - `3.0.1` | `7.0.x`      | [`phalconphp/build:debian-stretch`][:debian-stretch:] |

### CentOS (RHEL)

_Coming Soon_

### Fedora

_Coming Soon_

## Add new package repository

### DEB packages

_Stable releases:_
```sh
curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | sudo bash
```

_Nightly releases:_
```sh
curl -s https://packagecloud.io/install/repositories/phalcon/nightly/script.deb.sh | sudo bash
```

### Installation

**PHP 5**: _Ubuntu (trusty/wily), Debian (jessie)_

```sh
sudo apt-get install php5-phalcon
```

**PHP 7**: _Ubuntu (trusty,xenial), Debian (stretch)_

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
[:trusty-7:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-trusty-7.0/Dockerfile
[:ubuntu-trusty:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-trusty/Dockerfile
[:ubuntu-wily:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-wily/Dockerfile
[:ubuntu-xenial:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-xenial/Dockerfile
[:debian-jessie:]: https://github.com/phalcon/dockerfiles/blob/master/build/debian-jessie/Dockerfile
[:debian-stretch:]: https://github.com/phalcon/dockerfiles/blob/master/build/debian-stretch/Dockerfile
[:docs:]: https://github.com/phalcongelist/packagecloud/blob/master/docs/LICENSE.txt
