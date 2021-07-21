<p align="center"><a href="https://phalcon.io" target="_blank">
    <img src="https://assets.phalcon.io/phalcon/images/svg/phalcon-logo-transparent-black.svg" height="100" alt="Phalcon Builder"/>
</a></p>

<p align="center">
    <a href="https://travis-ci.org/phalcongelist/packagecloud">
        <img src="https://travis-ci.org/phalcongelist/packagecloud.svg" alt="Build Status" />
    </a>
</p>

Phalcon Builder - is a packaging system that make it easy and quick to build [Phalcon][1] packages such
as rpms, debs, etc. Phalcon's distribution that hosted at [PackageCloud][2].

Installation Instructions
-------------------------

How the Phalcon Team will schedule framework releases in the future:

- **Stable** versions correspond to Phalcon release tags and should be used in production
- **Mainline** versions correspond to Phalcon release tags which _are not stable_.
  Сan be used _with care_ by experienced users
- **Nightly** versions are built daily and _should not_ be used in production

Installation/configuration details for each version and operating system can be found below:

Supported Operating Systems
---------------------------

- Ubuntu 14.04 LTS (Trusty) (up to PHP 7.3)
- Ubuntu 16.04 LTS (Xenial)
- Ubuntu 18.04 LTS (Bionic)
- Ubuntu 20.04 LTS (Focal)
- Ubuntu 20.10 (Groovy)
- Debian 9 LTS (Stretch)
- Debian 10 (Buster)
- CentOS 7.2 LTS (Core)

Configuration
-------------

**DEB packages**

```sh
# Stable releases
curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | sudo bash

# Mainline releases
curl -s https://packagecloud.io/install/repositories/phalcon/mainline/script.deb.sh | sudo bash

# Nightly releases
curl -s https://packagecloud.io/install/repositories/phalcon/nightly/script.deb.sh | sudo bash
```

**RPM packages**

```sh
# Stable releases
curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.rpm.sh | sudo bash

# Mainline releases
curl -s https://packagecloud.io/install/repositories/phalcon/mainline/script.rpm.sh | sudo bash

# Nightly releases
curl -s https://packagecloud.io/install/repositories/phalcon/nightly/script.rpm.sh | sudo bash
```

**Programmatic way**

```bash
export BASE_URI=https://packagecloud.io/install/repositories
export PRODUCT=phalcon
export BRANCH=mainline
export PACKAGE=rpm

curl -s "${BASE_URI}/${PRODUCT}/${BRANCH}/script.${PACKAGE}.sh" | sudo bash
```

Installation
------------

Select the required package from the list using the command as follows:

**DEB packages**

```sh
# Phalcon PHP framework
apt-cache search phalcon | grep "High performance PHP framework"

# Debug symbols for Phalcon
apt-cache search phalcon-dbgsym
```

**RPM packages**

```sh
# Phalcon PHP framework
yum search phalcon | grep "High performance PHP framework"

# Debug symbols for Phalcon
yum search phalcon | grep "Debug information for package"
```

Download packages manually
--------------------------

* Packages for [stable version][3]
* Packages for [mainline version][4]
* Packages for [nightly version][5]

License
-------

Phalcon Builder licensed under the BSD 3-Clause License. See the [LICENSE][8] file for more information.

[1]: https://phalcon.io
[2]: https://packagecloud.io/phalcon
[3]: https://packagecloud.io/phalcon/stable
[4]: https://packagecloud.io/phalcon/mainline
[5]: https://packagecloud.io/phalcon/nightly
[8]: https://github.com/phalcon/zephir/blob/master/LICENSE
