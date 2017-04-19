# private configure class
class teamcity_agent::configure {


  file { '/lib/systemd/system/teamcity-agent.service':
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('teamcity_agent/teamcity_agent.systemd.erb'),
  } ~>
  exec { 'teamcity_agent-systemd-reload':
    command       => 'systemctl daemon-reload',
    path          => [ '/usr/bin', '/bin', '/usr/sbin' ],
    refreshonly   => true,
  }

  file { "${::teamcity_agent::extract_path}/BuildAgent/conf/buildAgent.properties":
    mode     => '0644',
    owner    => 'root',
    group    => 'root',
    content  => template('teamcity_agent/buildAgent.properties.erb')
  }


}
