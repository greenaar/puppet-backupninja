# Shell handler

define backupninja::entry::sqlite (
  $ensure         = $backupninja::ensure,
  $weight         = 95,
  $when           = '',
  $sqlite         = '/usr/bin/sqlite3',
  $gzip           = '/bin/gzip',
  $sourcepath     = '',
  $sourcefile     = '',
  $targetpath     = '',
  $targetfile     = '',
  $targetsuffix   = '',
  $compress       = true,
) {

  require backupninja::params

  file { "${backupninja::params::config_dir}/${weight}_${name}.sh" :
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/sqlite3.erb'),
  }
}

