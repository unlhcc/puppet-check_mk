
define check_mk::server {
  $omd_site_home           = "/opt/omd/sites/${name}"
  $check_mk_location       = "${omd_site_home}/etc/check_mk"
  $check_mk_agent_location = "${check_mk_location}/agents"

  # realize the .mk files for all check_mk_remote resources
  File<<| tag == 'check_mk_remote' |>>

  # FIXME: This was used to automagically inventory new services / reload OMD
  # every puppet run, but 'check_mk -I' can get stuck on badly behaving hosts
  # (tcp wait) and back up until everything explodes
  #
  # possibly use --no-tcp instead? still requires manual -I for new hosts...
  # for now just commenting it out completely
  #
  # force a check_mk update every puppet run
  #exec { "check_mk_update_${name}":
  #    command => "/bin/su - ${name} -c 'check_mk -I ; check_mk -O'",
  #    timeout => 1200,
  #}
}
