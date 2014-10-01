# ldap handler

define backupninja::entry::ldap (
  $ensure         = $backupninja::ensure,
  $weight         = 20,
  $when           = '',
  $backupdir      = "${backupninja::params::backupdir}/ldap",
  $configfile     = '/etc/ldap/slapd.conf',
  $databases      = 'all',
  $compress       = 'yes',
  $restartldap    = false,
  $method         = 'ldapsearch',
  $passwordfile    = undef,
  $binddn         = undef,
  $ldaphost       = undef,
  $ldapssl        = true,
  $ldaptls        = false,
  $handler        = 'ldap',
) {

  require backupninja::params

  file { $backupdir:
    ensure => 'directory',
    mode   => '0750',
    owner  => 'root',
  }

  file { "${backupninja::params::config_dir}/${weight}_${name}.${handler}" :
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/ldap.erb'),
  }
}
