# Bup handler
#  'bup-local':
#    type: 'bup'
#    ensure: present
#    weight: '60'
#    options:
#      include:
#        - '/etc'
#      type: 'local'
#      bupdir: '/backups/bup'

define backupninja::entry::bup (
  $ensure         = $backupninja::ensure,
  $weight         = 95,
  $when           = '',
  $ignoreversion  = false,
  $testconnect    = true,
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
  $type           = 'local',
  $bupdir         = '/var/backups/filesystem.bup',
  $remote_bupdir  = undef,
  $branch         = $::nodetype,
  $handler        = 'bup',
  $user           = undef,
  $host           = undef,
) {

  require backupninja::params

  file { $bupdir:
    ensure => 'directory',
    mode   => '0750',
    owner  => 'root',
  }

  file { "${backupninja::params::config_dir}/${weight}_${name}.${handler}" :
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/bup.erb'),
  }

}

