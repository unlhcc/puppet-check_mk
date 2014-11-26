
define check_mk::server {

    $omd_site_home           = "/opt/omd/sites/${name}"
    $check_mk_location       = "${omd_site_home}/etc/check_mk"
    $check_mk_agent_location = "${check_mk_location}/agents"

    File<<| tag == 'check_mk_remote' |>>

    # force a check_mk update every puppet run
    exec { "check_mk_update_${name}":
        command => "/bin/su - ${name} -c 'check_mk -I ; check_mk -O'",
    }

}
