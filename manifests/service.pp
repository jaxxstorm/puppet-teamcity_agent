# == Class teamcity_agent::service
#
# It ensure the service is running
class teamcity_agent::service {

  if teamcity_agent::manage_service {
    service { 'teamcity-agent':
    	ensure   => $teamcity_agent::service_ensure,
    	enable   => $teamcity_agent::service_enable, 
    }
  }
}
