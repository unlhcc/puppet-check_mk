# CheckMK Parameters
class check_mk::params {
  $omd_site = undef
  $install = false

  $check_mk_tags = undef
  $check_mk_alias = undef

  $check_mk_server = '127.0.0.1'

  $plugin_mk_inventory_enable  = false
  $plugin_mk_inventory_source  = '/usr/share/check-mk-agent/available-plugins/mk_inventory'

  if (versioncmp($facts['os']['release']['major'], '8') <= 0) {
    $plugin_active_location = '/usr/share/check-mk-agent/plugins'
    $plugin_local_location = '/usr/share/check-mk-agent/local'
  }
  else {
    $plugin_active_location = '/usr/lib/check_mk_agent/plugins'
    $plugin_local_location = '/usr/lib/check_mk_agent/local'
  }
}
