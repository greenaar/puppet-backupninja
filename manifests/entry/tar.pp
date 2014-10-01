# tar handler

define backupninja::entry::tar (
  $ensure         = $backupninja::ensure,
  $weight         = 20,
  $when           = '',
  $backupdir      = "${backupninja::params::backupdir}/tar",
  $backupname     = $::fqdn,
  $compress       = 'yes',
  $exclude        = [
    '/home/*/.gnupg',
  ],
  $include        = [
    '/var/spool/cron/crontabs',
    '/var/backups',
    '/etc',
    '/root',
    '/home',
    '/usr/local/*bin',
    '/var/lib/dpkg/status*'
  ],
  $handler        = 'tar',
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
    content => template('backupninja/entry/tar.erb'),
  }
}
