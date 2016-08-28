#  Phalcon Framework
#
#  Copyright (c) 2011-2016, Phalcon Team (https://www.phalconphp.com)
#
#  This source file is subject to the New BSD License that is bundled
#  with this package in the file https://www.phalconphp.com/LICENSE.txt
#
#  If you did not receive a copy of the license and are unable to
#  obtain it through the world-wide-web, please send an email
#  to license@phalconphp.com so we can send you a copy immediately.
#
#  Authors: Andres Gutierrez <andres@phalconphp.com>
#           Serghei Iakovlev <serghei@phalconphp.com>

%global php_apiver  %((rpm -E %php_core_api | cut -d '-' -f 1) | tail -1)
%global zend_apiver %((rpm -E %php_zend_api | cut -d '-' -f 1) | tail -1)
%global php_major   %((rpm -E %php_version | head -c 1) | tail -1)
%global real_name   php-phalcon
%global php_base    php56u
%global repo_vendor ius
%global ini_name    50-phalcon.ini

%global src_dir cphalcon/build/php%{php_major}/safe
%if %{__isa_bits} == 32
%global src_dir cphalcon/build/php%{php_major}/32bits
%endif
%if %{__isa_bits} == 64
%global src_dir cphalcon/build/php%{php_major}/64bits
%endif

Name: %{php_base}-phalcon
Version: %{version}
Release: 1.%{repo_vendor}%{?dist}
Summary: High performance PHP framework
Group: Development/Languages
Packager: Phalcon Buildbot <build@phalconphp.com>
License: BSD 3-Clause
URL: https://github.com/phalcon/cphalcon
Source0: phalcon-php-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildRequires: %{php_base}-devel
BuildRequires: %{php_base}-pecl-jsonc-devel
BuildRequires: pcre-devel
BuildRequires: re2c
Requires: %{php_base}-common
Requires: %{php_base}(zend-abi) = %{zend_apiver}
Requires: %{php_base}(api) = %{php_apiver}

%description
High performance PHP framework.

Phalcon is an open source web framework delivered as a C extension for
the PHP language providing high performance and lower resource consumption.

This package provides the Phalcon PHP extension.

%prep
%setup -q -n phalcon-php-%{version}

cat > %{ini_name} << 'EOF'
;
;  Phalcon Framework
;
;  Copyright (c) 2011-2016 Phalcon Team (https://www.phalconphp.com)
;
;  This source file is subject to the New BSD License that is bundled
;  with this package in the file https://www.phalconphp.com/LICENSE.txt
;
;  If you did not receive a copy of the license and are unable to
;  obtain it through the world-wide-web, please send an email
;  to license@phalconphp.com so we can send you a copy immediately.
;
;  Authors: Andres Gutierrez <andres@phalconphp.com>
;           Serghei Iakovlev <serghei@phalconphp.com>

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

EOF

%build
CFLAGS+="-g3 -fvisibility=hidden -DPHALCON_RELEASE"
export CFLAGS

LDFLAGS+="-Wl,--as-needed -Wl,-O1 -Wl,-Bsymbolic-functions"
export LDFLAGS
ls -l

cd %{src_dir}
%{_bindir}/phpize
%configure --enable-phalcon=shared \
           --with-php-config=%{_bindir}/php-config
%{__make} %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT
%{__make} -C %{src_dir} install INSTALL_ROOT=$RPM_BUILD_ROOT

# Drop in the bit of configuration
install -D -m 644 %{ini_name} %{buildroot}%{php_inidir}/%{ini_name}

%clean
rm -rf $RPM_BUILD_ROOT

cd %{src_dir}
[ -f Makefile ] && %{__make} distclean; \
  %{_bindir}/phpize --clean; \
  rm -f tmp-php.ini

%files
%defattr(-,root,root,-)
%{php_extdir}/phalcon.so
%config(noreplace) %{php_inidir}/%{ini_name}
/usr/include/php/ext/phalcon/php_phalcon.h

%changelog
* Wed Aug 24 2016 Serghei Iakovlev <serghei@phalconphp.com> - %{version}-%{release}.%{repo_vendor}
- Fixed Phalcon\Cache\Backend\Redis::flush in order to flush cache correctly
- Fixed Phalcon\Mvc\Model\Manager::getRelationRecords to correct using multi relation column #12035
- Fixed Phalcon\Acl\Resource. Now it implements Phalcon\Acl\ResourceInterface #11959
- Fixed save method for all cache backends. Now it updates the _lastKey property correctly #12050
- Fixed virtual foreign key check when having multiple keys #12071
- Phalcon\Config\Adapter\Ini constructor can now specify parse_ini_file() scanner mode #12079
- Fixed Phalcon\Cache\Backend\Apc::save due to which the Apc::increment/Apc::decrement could not be used properly #12109
- Fixed Phalcon\Mvc\Model\Criteria::inWhere so that now the second parameter can be an empty array #10676
- Fixed ORM related memory leak #12115, #11995, #12116
- Fixed incorrect Phalcon\Mvc\View::getActiveRenderPath behavior #12139
- Fixed Phalcon\Security\Random::base64Safe so that now the method returns correct safe string #12141
- Fixed the Phalcon\Translate\Adapter\Gettext::getOptionsDefault visibility #12157
- Enabled PHQL cache for PHP7 to improve performance and reuse plannings
