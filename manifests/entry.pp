# Hiera passthrough handler

define backupninja::entry (
  $type,
  $options,
  $ensure = $backupninja::ensure,
  $weight = undef,
  $when   = undef,
) {

  case $type {
    'duplicity': {
      backupninja::entry::duplicity { $name:
        ensure             => $ensure,
        weight             => $weight,
        when               => $when,
        # Duplicity
        options            => $options[options],
        nicelevel          => $options[nicelevel],
        testconnect        => $options[testconnect],
        sign               => $options[sign],
        encryptkey         => $options[encryptkey],
        signkey            => $options[signkey],
        password           => $options[password],
        include            => $options[include],
        exclude            => $options[exclude],
        incremental        => $options[incremental],
        increments         => $options[increments],
        keep               => $options[keep],
        desturl            => $options[desturl],
        awsaccesskeyid     => $options[awsaccesskeyid],
        awssecretaccesskey => $options[awssecretaccesskey],
        ftp_password       => $options[ftp_password],
        bandwidthlimit     => $options[bandwidthlimit],
        sshoptions         => $options[sshoptions],
        destdir            => $options[destdir],
        desthost           => $options[desthost],
        destuser           => $options[destuser],
      }
    }
    'sys': {
      backupninja::entry::sys { $name:
        ensure             => $ensure,
        weight             => $weight,
        when               => $when,
        packages           => $options[packages],
        packagesfile       => $options[packagesfile],
        partitions         => $options[partitions],
        partitionsfile     => $options[partitionsfile],
        dosfdisk           => $options[dosfdisk],
        hardware           => $options[hardware],
        hardwarefile       => $options[hardwarefile],
        dohwinfo           => $options[dohwinfo],
        doluks             => $options[doluks],
        dolvm              => $options[dolvm],
      }
    }
    'rdiff': {
      backupninja::entry::rdiff { $name:
        ensure             => $ensure,
        weight             => $weight,
        when               => $when,
        user               => $options[user],
        backupdir          => $options[backupdir],
        host               => $options[host],
        type               => $options[type],
        exclude            => $options[exclude],
        include            => $options[include],
        vsinclude          => $options[vsinclude],
        keep               => $options[keep],
        sshoptions         => $options[sshoptinos],
        options            => $options[options],
        backuptag          => $options[backuptag],
        extras             => $options[extras],
        ignoreversion      => $options[ignoreversion],
        nicelevel          => $options[nicelevel],
        bwlimit            => $options[bwlimit],
        testconnect        => $options[testconnect],
      }
    }
    'mysql': {
      backupninja::entry::mysql { $name:
        ensure         => $ensure,
        weight         => $weight,
        when           => $when,
        # MySQL
        hotcopy        => $options[hotcopy],
        sqldump        => $options[sqldump],
        sqldumpoptions => $options[sqldumpoptions],
        compress       => $options[compress],
        dbhost         => $options[dbhost],
        backupdir      => $options[backupdir],
        databases      => $options[databases],
        user           => $options[user],
        dbusername     => $options[dbusername],
        dbpassword     => $options[dbpassword],
        configfile     => $options[configfile],
        nodata         => $options[nodata],
        nodata_any     => $options[nodata_any],
        vsname         => $options[vsname],
        handler        => $options[handler],
      }
    }
    'pgsql': {
      backupninja::entry::pgsql { $name:
        ensure         => $ensure,
        weight         => $weight,
        when           => $when,
        # PGSQL
        compress       => $options[compress],
        backupdir      => $options[backupdir],
        databases      => $options[databases],
        format         => $options[format],
        handler        => $options[handler],
      }
    }
    'mongodb': {
      backupnina::entry::mongodb { $name:
        ensure         => $ensure,
        weight         => $weight,
        when           => $when,
        # Mongo
        mongodump      => $options[mongodump],
        backupdir      => $options[backupdir],
        databases      => $options[databases],
        collections    => $options[collections],
        dbhost         => $options[dbhost],
        mongouser      => $options[mongouser],
        mongopass      => $options[mongopass],
        handler        => $options[handler],
      }
    }
    'ldap': {
      backupninja::entry::ldap { $name:
        ensure       => $ensure,
        weight       => $weight,
        when         => $when,
        backupdir    => $options[backupdir],
        configfile   => $options[configfile],
        databases    => $options[databases],
        compress     => $options[compress],
        restartldap  => $options[restartldap],
        method       => $options[method],
        passwordfile => $options[passwordfile],
        binddn       => $options[binddn],
        ldaphost     => $options[ldaphost],
        ldapssl      => $options[ldapssl],
        ldaptls      => $options[ldaptls],
        handler      => $options[handler],
      }
    }
    'bup': {
      backupninja::entry::bup { $name:
        ensure        => $ensure,
        weight        => $weight,
        when          => $when,
        testconnect   => $options[testconnect],
        ignoreversion => $options[ignoreversion],
        handler       => $options[handler],
        exclude       => $options[exclude],
        include       => $options[include],
        user          => $options[user],
        bupdir        => $options[bupdir],
        remote_bupdir => $options[remote_bupdir],
        branch        => $options[branch],
        host          => $options[host],
        type          => $options[type],
      }
    }
    'tar': {
      backupninja::entry::tar { $name:
        ensure       => $ensure,
        weight       => $weight,
        when         => $when,
        backupdir    => $options[backupdir],
        backupname   => $options[backupname],
        compress     => $options[compress],
        handler      => $options[handler],
        exclude      => $options[exclude],
        include      => $options[include],
      }
    }
    'sqlite': {
      backupninja::entry::sqlite { $name:
        ensure       => $ensure,
        weight       => $weight,
        when         => $when,
        sqlite       => $options[sqlite],
        gzip         => $options[gzip],
        sourcepath   => $options[sourcepath],
        sourcefile   => $options[sourcefile],
        targetpath   => $options[targetpath],
        targetfile   => $options[targetfile],
        targetsuffix => $options[targetsuffix],
        compress     => $options[compress],
      }
    }
    's3': {
      backupninja::entry::s3 { $name:
        ensure   => $ensure,
        weight   => $weight,
        when     => $when,
        source   => $options[source],
        bucket   => $options[bucket],
        s3cmd    => $options[s3cmd],
        options  => $options[options],
        handler  => $options[handler],
      }
    }
    'sh': {
      backupninja::entry::sh { $name:
        ensure   => $ensure,
        weight   => $weight,
        when     => $when,
        commands => $options[commands],
      }
    }
    default: {
      fail "Uknown type ${type} for backupninja::entry"
    }
  }

}
