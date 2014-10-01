# Load external handler

define backupninja::load_extra_handler ( $helper = true ) {
  $helper_source = $helper ? {
    true    => "puppet:///modules/backupninja/handlers/${name}.helper.in",
    false   => undef,
    default =>  undef,
  }
  backupninja::handler { $name :
    handler_source => "puppet:///modules/backupninja/handlers/${name}.in",
    helper_source  => $helper_source,
  }
}

