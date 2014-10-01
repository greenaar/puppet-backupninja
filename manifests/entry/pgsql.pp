# pgsql handler

define backupninja::entry::pgsql (
  $ensure         = $backupninja::ensure,
  $weight         = 20,
  $when           = '',
  $compress       = 'yes',
  $backupdir      = "${backupninja::params::backupdir}/pgsql",
  $databases      = 'all',
  $handler        = 'pgsql',
  $format         = 'plain'
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
    content => template('backupninja/entry/pgsql.erb'),
  }
}
