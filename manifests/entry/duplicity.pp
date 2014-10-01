# Duplicity encrypted transfer handler
#
#  Hiera example
#
#backupnina::entries
#  duplicity:
#    type: duplicity
#    when: 'everyday at 18'
#    options :
#      options: '--verbosity 8'
#      keep: '7'
#      nicelevel: 10
#      password: 'password'
#      include:
#        - '/var/spool/cron/crontabs'
#        - '/var/backups'
#        - '/etc'
#        - '/root'
#        - '/home'
#        - '/usr/local/*bin'
#        - '/var/lib/dpkg/status*'
#        - '/share/bin'
#      desturl: "file:///backups/%{::fqdn}/duplicity"
#  'duplicity-s3':
#    type: 'duplicity'
#    ensure: absent
#    weight: '55'
#    options:
#      keep: '1'
#      options: '--s3-use-new-style'
#      nicelevel: 20
#      password: 'albatross'
#      include:
#        - '/etc'
#      desturl: 's3+http://bucket/duplicity/'
#      awsaccesskeyid: 'XXXXXXXXXXXXXXX'
#      awssecretaccesskey: 'XXXXXXXXXXXXXXXXX'
#
#  desturl options:
#  desturl = file:///usr/local/backup
#  desturl = rsync://user@other.host//var/backup/bla
#  desturl = s3+http://your_bucket
#  desturl = ftp://myftpuser@ftp.example.org/remote/ftp/path

define backupninja::entry::duplicity (
  $ensure             = $backupninja::ensure,
  $weight             = 90,
  $when               = '',
  $options            = '--s3-use-new-style',
  $nicelevel          = 19,
  $testconnect        = false,
  $sign               = false,
  $encryptkey         = '',
  $signkey            = '',
  $password           = '',
  $include            = [
    '/var/spool/cron/crontabs',
    '/var/backups',
    '/etc',
    '/root',
    '/home',
    '/usr/local/*bin',
    '/var/lib/dpkg/status*',
  ],
  $exclude            = [
    '/home/*/.gnupg',
    '/home/*/.local/share/Trash',
    '/home/*/.Trash',
    '/home/*/.thumbnails',
    '/home/*/.beagle',
    '/home/*/.aMule',
    '/home/*/gtk-gnutella-downloads',
    '/var/cache/backupninja/duplicity',
  ],
  $incremental        = true,
  $increments         = '30',
  $keep               = '60',
  $desturl            = '',
  $awsaccesskeyid     = '',
  $awssecretaccesskey = '',
  $ftp_password       = '',
  $bandwidthlimit     = '',
  $sshoptions         = '',
  $destdir            = '',
  $desthost           = '',
  $destuser           = '',
) {

  file { "${backupninja::params::config_dir}/${weight}_${name}.dup" :
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/duplicity.erb'),
  }
}
