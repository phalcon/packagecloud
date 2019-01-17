# This file is part of the Phalcon Builder.
#
# (c) Phalcon Team <team@phalconphp.com>
#
# For the full copyright and license information, please view
# the LICENSE file that was distributed with this source code.
#
# If you did not receive a copy of the license it is available
# through the world-wide-web at the following url:
# https://license.phalconphp.com
#
# If you did not receive a copy of the license and are unable to
# obtain it through the world-wide-web, please send an email
# to license@phalconphp.com so we can send you a copy immediately.

%global with_zts    0%{?__ztsphp:1}
%global with_tests  %{?_with_tests:1}%{!?_with_tests:0}
%global php_apiver  %((rpm -E %php_core_api | cut -d '-' -f 1) | tail -1)
%global zend_apiver %((rpm -E %php_zend_api | cut -d '-' -f 1) | tail -1)

# after 40-json.ini, 20-pdo.ini and 40-prs.ini (if any)
%global ini_name 50-phalcon.ini

%global src_dir build/php7/safe
%if %{__isa_bits} == 32
%global src_dir build/php7/32bits
%endif
%if %{__isa_bits} == 64
%global src_dir build/php7/64bits
%endif

%if 0%{?fedora} >= 17 || 0%{?rhel} >= 7
%global with_libpcre  1
%else
%global with_libpcre  0
%endif

%global phalcon_major %((rpm -E %version  | cut -d. -f1) | tail -1)

%{!?zts_php_extdir: %{expand: %%define zts_php_extdir %(zts-php-config --extension-dir)}}

Name: php71u-phalcon
Version: %{version}
# will be replaced by the automated script
Release: 1.ius%{?dist}
Summary: High performance PHP framework
Group: Development/Libraries
Packager: Phalcon Team <build@phalconphp.com>
License: BSD 3-Clause
URL: https://github.com/phalcon/cphalcon
Source0: phalcon-php-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildRequires: php71u-devel%{?_isa}
%if %{with_libpcre}
BuildRequires: pcre-devel%{?_isa} >= 8.20
%endif

%if "%{phalcon_major}" == "4"
Requires: php-pecl-psr%{?_isa}
BuildRequires: php-pecl-psr%{?_isa}
BuildRequires: php-pecl-psr-devel%{?_isa}
%endif

BuildRequires: re2c%{?_isa}

Requires: php71u-pdo%{?_isa}
Requires: php71u-common%{?_isa}
Requires: php(zend-abi) = %{php_zend_api}
Requires: php(api) = %{php_core_api}

%description
High performance PHP framework.

Phalcon is an open source web framework delivered as a C extension for
the PHP language providing high performance and lower resource consumption.

This package provides the Phalcon PHP extension.

Documentation: https://docs.phalconphp.com

%prep
%setup -q -n phalcon-php-%{version}

%{__cat} > %{ini_name} << 'EOF'
;
; This file is part of the Phalcon.
;
; (c) Phalcon Team <team@phalconphp.com>
;
; For the full copyright and license information, please view
; the LICENSE.txt file that was distributed with this source code.
;
; If you did not receive a copy of the license it is available
; through the world-wide-web at the following url:
; https://license.phalconphp.com
;
; If you did not receive a copy of the license and are unable to
; obtain it through the world-wide-web, please send an email
; to license@phalconphp.com so we can send you a copy immediately.

; %{summary}
[phalcon]
extension = phalcon.so

; ----- Options to use the Phalcon Framework

; phalcon.db.escape_identifiers = On
; phalcon.db.force_casting = Off

; phalcon.orm.events = On
; phalcon.orm.virtual_foreign_keys = On
; phalcon.orm.column_renaming = On
; phalcon.orm.not_null_validations = On
; phalcon.orm.exception_on_failed_save = Off
; phalcon.orm.enable_literals = On
; phalcon.orm.late_state_binding = Off
; phalcon.orm.enable_implicit_joins = On
; phalcon.orm.cast_on_hydrate = Off
; phalcon.orm.ignore_unknown_columns = Off
; phalcon.orm.update_snapshot_on_save = On
; phalcon.orm.disable_assign_setters = Off

EOF

%build
extconf() {
%configure \
  --enable-phalcon \
  --with-libdir=%{_lib} \
  --with-php-config=$1
}

: Generate the SAFE sources

CFLAGS+="-O2 -fvisibility=hidden -finline-functions"
LDFLAGS+="-Wl,--as-needed -Wl,-Bsymbolic-functions"

export CC="gcc"
export LDFLAGS
export CFLAGS
export CPPFLAGS="-DPHALCON_RELEASE"

%{__mv} %{src_dir} build/NTS

%if %{with_zts}
: Duplicate source tree for NTS / ZTS build
%{__cp} -r build/NTS build/ZTS
%endif

: Build NTS extension
cd build/NTS
%{_bindir}/phpize
extconf %{_bindir}/php-config
%{__make} %{?_smp_mflags}

%if %{with_zts}
: Build ZTS extension
cd ../ZTS
%{_bindir}/zts-phpize
extconf %{_bindir}/zts-php-config
%{__make} %{?_smp_mflags}
%endif

%install
%{__rm} -rf ${buildroot}
%{__make} -C build/NTS install INSTALL_ROOT=%{buildroot}
%{__install} -D -m 644 %{ini_name} %{buildroot}%{php_inidir}/%{ini_name}

%if %{with_zts}
%{__make} -C build/ZTS install INSTALL_ROOT=%{buildroot}
%{__install} -Dpm644 %{ini_name} %{buildroot}%{php_ztsinidir}/%{ini_name}
%endif

%check
%{__cc} --version
%{__php} --version

: Get needed extensions for NTS check
modules=""
for mod in json pdo; do
  if [ -f %{php_extdir}/${mod}.so ]; then
    modules="$modules -d extension=${mod}.so"
  fi
done

%if "%{phalcon_major}" == "4"
	if [ -f "%{php_extdir}/psr.so" ]; then
		modules="$modules -d extension=psr.so"
	fi
%endif

: Minimal load test for NTS extension
%{__php} --no-php-ini \
    $modules \
    -d extension=%{buildroot}%{php_extdir}/phalcon.so \
    --ri phalcon

%if %{with_tests}
: Upstream test suite NTS extension
cd build/NTS
SKIP_ONLINE_TESTS=1 \
TEST_PHP_EXECUTABLE=%{__php} \
TEST_PHP_ARGS="-n $modules -d extension=$PWD/modules/phalcon.so" \
NO_INTERACTION=1 \
REPORT_EXIT_STATUS=1 \
%{__php} -n run-tests.php --show-diff
%endif

: Get needed extensions for ZTS check
modules=""
for mod in json pdo; do
  if [ -f %{zts_php_extdir}/${mod}.so ]; then
    modules="$modules -d extension=${mod}.so"
  fi
done

%if "%{phalcon_major}" == "4"
	if [ -f "%{zts_php_extdir}/psr.so" ]; then
		modules="$modules -d extension=psr.so"
	fi
%endif

%if %{with_zts}
: Minimal load test for ZTS extension
%{__ztsphp} --no-php-ini \
    $modules \
    -d extension=%{buildroot}%{php_ztsextdir}/phalcon.so \
    --ri phalcon
%endif

%clean
extclean() {
[ -f Makefile ] && %{__make} distclean; \
    %{_bindir}/$1 --clean; \
    %{__rm} -f tmp-php.ini
}

cd build/NTS
extclean phpize

%if %{with_zts}
cd ../ZTS
extclean zts-phpize
%endif

%{__rm} -rf ${buildroot}

%files
%defattr(-,root,root,-)
%{!?_licensedir:%global license %%doc}
%license LICENSE.txt
%if "%{phalcon_major}" == "4"
%doc CHANGELOG-4.0.md
%endif
%doc BACKERS.md
%doc CHANGELOG.md
%doc CONTRIBUTING.md
%doc README.md

%{php_extdir}/phalcon.so
%config(noreplace) %{php_inidir}/%{ini_name}
%{php_incldir}/ext/phalcon/php_phalcon.h

%if %{with_zts}
%{php_ztsextdir}/phalcon.so
%config(noreplace) %{php_ztsinidir}/%{ini_name}
%{php_ztsincldir}/ext/phalcon/php_phalcon.h
%endif

%changelog
