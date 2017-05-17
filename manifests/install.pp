class teamcity_agent::install {

  include ::archive

  file { $teamcity_agent::extract_path :
    ensure => directory,
  }
  -> file { $teamcity_agent::archive_path :
    ensure => directory,
  }

  archive { "${teamcity_agent::archive_path}/BuildAgent.zip" :
    ensure       => present,
    extract      => true,
    extract_path => $teamcity_agent::extract_path,
    source       => $::teamcity_agent::real_download_url,
    creates      => "${teamcity_agent::extract_path}/BuildAgent/bin/agent.sh"
  }


}
