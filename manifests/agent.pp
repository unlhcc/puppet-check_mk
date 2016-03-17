
define check_mk::agent (

    $check_mk_tags   = $check_mk::params::check_mk_tags,
    $check_mk_alias  = $check_mk::params::check_mk_alias,
    $check_mk_server = $check_mk::params::check_mk_server,

    $omd_site_home           = "/opt/omd/sites/${name}",
    $check_mk_location       = "${omd_site_home}/etc/check_mk",
    $check_mk_agent_location = "${check_mk_location}/agents",

    $plugin_mk_invnentory_enable = $check_mk::params::plugin_mk_inventory_enable,
    $plugin_mk_inventory_source  = $check_mk::params::plugin_mk_inventory_source,
    $plugin_active_location      = $check_mk::params::plugin_active_location,

) {

    # exported resource for a monitored host
    @@file { "${check_mk_location}/conf.d/main/${::fqdn}.mk":
            ensure  => file,
            content => template('check_mk/main.erb'),
            tag     => 'check_mk_remote',
    }

    # xinetd.d configuration
    file { '/etc/xinetd.d/check-mk-agent':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('check_mk/check-mk-agent.erb'),
        notify  => Service[xinetd],
    }

    # symlink mk_inventory plugin to activate if enabled
    if $check_mk::plugin_mk_inventory_enable == true {
        file { "${plugin_active_location}/mk_inventory":
            ensure => 'link',
            target => $check_mk::plugin_mk_inventory_source,
        }
    }
    else
    {
        file { "${plugin_active_location}/mk_inventory":
            ensure => 'absent',
        }
    }

}
