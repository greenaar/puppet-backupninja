# s3 handler

define backupninja::entry::s3 (
  $ensure         = $backupninja::ensure,
  $weight         = 20,
  $when           = '',
  $source         = '',
  $bucket         = '',
  $s3cmd          = '/usr/bin/s3cmd',
  $options        = '--recursive --rr',
  $handler        = 's3',
) {

  require backupninja::params

  file { "${backupninja::params::config_dir}/${weight}_${name}.${handler}" :
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/s3.erb'),
  }
}


