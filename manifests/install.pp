# Install backupninja package

class backupninja::install () {

  require backupninja::params

  if !defined(Package[$backupninja::params::package_name]) {
    package { $backupninja::params::package_name:
      ensure  => $backupninja::package_ensure,
    }
  }
}
