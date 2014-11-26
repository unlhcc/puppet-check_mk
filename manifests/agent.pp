
define check_mk::agent (

    $check_mk_tags   = $check_mk::params::check_mk_tags,
    $check_mk_alias  = $check_mk::params::check_mk_alias,
    $check_mk_server = $check_mk::params::check_mk_server,

    $omd_site_home           = "/opt/omd/sites/${name}",
    $check_mk_location       = "${omd_site_home}/etc/check_mk",
    $check_mk_agent_location = "${check_mk_location}/agents",

) {

    # exported resource for a monitored host
    @@file { "${check_mk_location}/conf.d/main/${::hostname}.mk":
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
    }

}
