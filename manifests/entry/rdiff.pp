# Run rdiff-backup as part of a backupninja run.
#
# Valid attributes for this type are:
#
#   weight: The prefix to give to the handler config filename, to set
#      weight in which the actions are executed during the backup run.
#
#   ensure: Allows you to delete an entry if you don't want it any more
#      (but be sure to keep the configdir, name, and weight the same, so
#      that we can find the correct file to remove).
#
#   keep, include, exclude, type, host, directory, user, sshoptions: As
#      defined in the backupninja documentation.  The options will be placed
#      in the correct sections automatically.  The include and exclude
#      options should be given as arrays if you want to specify multiple
#      directories.
#
define backupninja::entry::rdiff (
  $weight               = 90,
  $when                 = '',
  $ensure               = $backupninja::ensure,
  $type                 = 'local',
  $host                 = false,
  $user                 = false,
  $sshoptions           = false,
  $backupdir            = "${backupninja::params::backupdir}/rdiff-backup",
  $exclude              = [
    '/home/*/.gnupg',
    '/home/*/.local/share/Trash',
    '/home/*/.Trash',
    '/home/*/.thumbnails',
    '/home/*/.beagle',
    '/home/*/.aMule',
    '/home/*/gtk-gnutella-downloads'
  ],
  $include              = [
    '/var/spool/cron/crontabs',
    '/var/backups',
    '/etc',
    '/root',
    '/home',
    '/usr/local/*bin',
    '/var/lib/dpkg/status*'
  ],
  $vsinclude            = false,
  $keep                 = 30,
  $options              = '--force',
  $backuptag            = false,
  $extras               = false,
  $ignoreversion        = false,
  $nicelevel            = '10',
  $bwlimit              = false,
  $testconnect          = true,
) {

  case $type {
    'local': {
      if !defined(File[$backupdir]) {
        file { $backupdir:
          ensure => 'directory',
          mode   => '0750',
          owner  => 'root',
        }
      }
    }
    'remote': {
      case $host {
        false: {
          err ('need to define a host for remote backups!')
        }
        default: {
          err ('need to define a host for remote backups!')
        }
      }
    }
    default: {}
  }
  file { "${backupninja::params::config_dir}/${weight}_${name}.rdiff":
    ensure  => $ensure,
    content => template('backupninja/entry/rdiff.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
  }
}
