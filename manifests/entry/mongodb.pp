# mongodb handler

define backupninja::entry::mongodb (
  $ensure         = $backupninja::ensure,
  $weight         = 20,
  $when           = '',
  $backupdir      = "${backupninja::params::backupdir}/mongodb",
  $mongodump      = '/usr/bin/mongodump',
  $databases      = '',
  $collections    = '',
  $dbhost         = 'localhost',
  $mongouser      = '',
  $mongopass      = '',
  $handler        = 'mongodb',
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
    content => template('backupninja/entry/mongodb.erb'),
  }
}

