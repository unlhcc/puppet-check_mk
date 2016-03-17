
class check_mk::params {

    $omd_site = $::check_mk_omd_site ? {
        ''      => 'ALL',
        default => $::check_mk_omd_site,
    }

    $install = $::check_mk_install ? {
        ''      => 'ALL',
        default => $::check_mk_install,
    }

    $check_mk_tags = $::check_mk_check_mk_tags ? {
        ''      => 'ALL',
        default => $::check_mk_check_mk_tags,
    }

    $check_mk_alias = $::check_mk_check_mk_alias ? {
        ''      => 'ALL',
        default => $::check_mk_check_mk_alias,
    }

    $check_mk_server = '127.0.0.1'

    $plugin_mk_invnentory_enable = false
    $plugin_mk_inventory_source  = '/usr/share/check-mk-agent/available-plugins/mk_inventory'
    $plugin_active_location      = '/usr/share/check-mk-agent/plugins'

}
