# Mysql handler
#
# Hiera Example
#
# backupninja::entries :
#  database :
#    type    : mysql
#    when    : 'everyday at 18'
#    options :
#      hotcopy    : false
#      nodata_any : [cache, sessions, watchdog]

define backupninja::entry::mysql (
  $ensure         = $backupninja::ensure,
  $weight         = 20,
  $when           = '',
  $hotcopy        = false,
  $sqldump        = true,
  $sqldumpoptions = '--lock-tables --complete-insert --add-drop-table --quick --quote-names',
  $compress       = false,
  $dbhost         = '',
  $backupdir      = "${backupninja::params::backupdir}/mysql",
  $databases      = 'all',
  $user           = '',
  $dbusername     = '',
  $dbpassword     = '',
  $configfile     = $backupninja::params::mysql_configfile,
  $nodata         = '',
  $nodata_any     = [],
  $vsname         = '',
  $handler        = 'mysql',
) {

  require backupninja::params

  validate_array($nodata_any)

  # TODO: do some validations
  $db_array = split($databases, ' ')

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
    content => template('backupninja/entry/mysql.erb'),
  }
}
