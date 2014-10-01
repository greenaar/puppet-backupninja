# sys handler, as part of a backupninja run.
#
# Valid attributes for this type are:
#
#   order: The prefix to give to the handler config filename, to set
#      order in which the actions are executed during the backup run.
#
#   ensure: Allows you to delete an entry if you don't want it any more
#      (but be sure to keep the configdir, name, and order the same, so
#      that we can find the correct file to remove).
#
#
define backupninja::entry::sys (
  $weight          = 30,
  $when            = '',
  $ensure          = $backupninja::ensure,
  $packages        = true,
  $partitions      = true,
  $hardware        = false,
  $parentdir       = "${backupninja::params::backupdir}/sys",
  $packagesfile    = "${backupninja::params::backupdir}/sys/dpkg-selections.txt",
  $selectionsfile  = "${backupninja::params::backupdir}/sys/debconfsel.txt",
  $partitionsfile  = "${backupninja::params::backupdir}/sys/partitions.__star__.txt",
  $hardwarefile    = "${backupninja::params::backupdir}/sys/hardware.txt",
  $luksheadersfile = "${backupninja::params::backupdir}/sys/luksheader.__star__.bin",
  $dosfdisk        = true,
  $dohwinfo        = false,
  $doluks          = false,
  $dolvm           = true,
  $backupdir       = "${backupninja::params::backupdir}/sys"
) {

  require backupninja::params

  file { "${backupninja::params::config_dir}/${weight}_${name}.sys":
    ensure  => $ensure,
    content => template('backupninja/entry/sys.erb'),
    owner   => root,
    group   => root,
    mode    => '0600',
  }

  file { $backupdir:
    ensure => 'directory',
    mode   => '0750',
    owner  => 'root',
  }

}
