# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Added
- Install missed PHP extensions on non-stable branches to regenerate C-code

## [1.5.0] - 2019-02-31
### Added
- Added PHP 7.3 support
- The rpm spec files were divided regarding PHP versions

## [1.4.0] - 2019-01-06
### Added
- Added https://packagecloud.io/phalcon/mainline support

### Changed
- Fully refactored build matrix to allow build Phalcon 3.x and 4.x

## [1.3.0] - 2018-07-28
### Added
- Added ability to build packages for Ubuntu 18.04
  - [phalcongelist/packagecloud#27](https://github.com/phalcongelist/packagecloud/issues/27)
  - [phalcon/cphalcon#13376](https://github.com/phalcon/cphalcon/issues/13376)
- Added a common Debian/Ubuntu `prebuild.sh` script

### Changed
- Freezed packpack version to make sure that we use the same packpack always

### Fixed
- Added `TMPDIR` variable to the build container [packpack/packpack#97](https://github.com/packpack/packpack/issues/97)

## [1.2.3] - 2018-03-10
### Fixed
- Patching packpack due to [packpack/packpack#84](https://github.com/packpack/packpack/pull/84#issuecomment-371755389)

## [1.2.2] - 2017-07-10
### Changed
- Removed no longer needed `patching-sources` target

## [1.2.1] - 2017-06-21
### Changed
- Improved RPM-spec by removing hardcoded virtual provides specific things
- Use stable Zephir Parser
- Updated license path
- Patching `zend_error_noreturn` usage [phalcon/cphalcon#12909](https://github.com/phalcon/cphalcon/issues/12909)

## [1.2.0] - 2017-04-06
### Added
- Added ability to build PHP 7.1 packages

### Changed
- Used latest Zephir and Zephir Parser to generate nighly builds
- Cleaned not needed changelogs
- Improved debian rules to correct handle PHP 7.1

## Fixed
- Fixed file package file name to be able release a few versions for one distro

## [1.1.0] - 2017-03-22
### Changed
- Improved preparing build
- Used original https://github.com/packpack/packpack.git repo to build packages
- Removed patching headers target
- Renamed debug symbols for Debain/Ubuntu

## 1.0.0 - 2017-03-14
### Added
 - Initial stable release. Added ability to build packages for
Ubuntu 14.04-16.04, Debian 8.5-9 and CentOS 7.2 by using
[Packpack](https://github.com/packpack/packpack).

[Unreleased]: https://github.com/phalcongelist/packagecloud/compare/v1.5.0...HEAD
[1.5.0]: https://github.com/phalcongelist/packagecloud/compare/v1.4.0...v1.5.0
[1.4.0]: https://github.com/phalcongelist/packagecloud/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/phalcongelist/packagecloud/compare/v1.2.3...v1.3.0
[1.2.3]: https://github.com/phalcongelist/packagecloud/compare/v1.2.2...v1.2.3
[1.2.2]: https://github.com/phalcongelist/packagecloud/compare/v1.2.1...v1.2.2
[1.2.1]: https://github.com/phalcongelist/packagecloud/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/phalcongelist/packagecloud/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/phalcongelist/packagecloud/compare/v1.0.0...v1.1.0
