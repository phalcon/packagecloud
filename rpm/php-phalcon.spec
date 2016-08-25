%global php_apiver %((echo 0; php -i 2>/dev/null | sed -n 's/^PHP API => //p') | tail -1)
%global php_extdir %(php-config --extension-dir 2>/dev/null || echo "undefined")
%global php_version %(php-config --version 2>/dev/null || echo 0)

Name: php-phalcon
Version: 3.0.1
Release: 1%{?dist}
Summary: High performance PHP framework
Group: Development/Libraries
License: BSD 3-Clause
URL: https://github.com/phalcon/cphalcon
Source0: phalcon-php-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildRequires: php56u-devel
Requires: php(zend-abi) = %{php_zend_api}
Requires: php(api) = %{php_apiver}

%global ini_name 50-phalcon.ini

%description
High performance PHP framework
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
%{_bindir}/phpize
%configure
make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT
make install INSTALL_ROOT=$RPM_BUILD_ROOT
# Drop in the bit of configuration
install -D -m 644 %{ini_name} %{buildroot}%{php_inidir}/%{ini_name}

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%{php_extdir}/phalcon.so
%config(noreplace) %{php_inidir}/%{ini_name}
