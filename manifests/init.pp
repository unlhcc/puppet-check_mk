
class check_mk (
    $omd_site        = $check_mk::params::omd_site,
    $install         = $check_mk::params::install,
    $check_mk_tags   = $check_mk::params::check_mk_tags,
    $check_mk_alias  = $check_mk::params::check_mk_alias,
    $check_mk_server = $check_mk::params::check_mk_server,
    $plugin_mk_inventory_enable = $check_mk::params::plugin_mk_inventory_enable,
    $plugin_mk_inventory_source = $check_mk::params::plugin_mk_inventory_source,
    $plugin_active_location     = $check_mk::params::plugin_active_location,
) inherits check_mk::params {

    if $check_mk::install == 'agent' {

        $omd_site_home = "/opt/omd/sites/${omd_site}"
        $check_mk_location = "${omd_site_home}/etc/check_mk"
        $check_mk_agent_location = "${check_mk_location}/agents"

        case $::osfamily {
            'RedHat': {
                package { 'check-mk-agent': ensure => latest }
            }

            default: { notify { 'No support for check_mk agent on this OS': } }
        }

        check_mk::agent { $omd_site:
            omd_site_home           => $omd_site_home,
            check_mk_location       => $check_mk_location,
            check_mk_agent_location => $check_mk_agent_location,
            check_mk_server         => $check_mk_server,
            check_mk_tags           => $check_mk_tags,
            check_mk_alias          => $check_mk_alias,
        }
    }

    if $check_mk::install == 'server' {
        check_mk::server { $omd_site: }
    }

}
