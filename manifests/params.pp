# Private params class
class teamcity_agent::params {

  $archive_path   = '/opt/teamcity/archives'
  $extract_path   = '/opt/teamcity'
  $server_scheme  = 'http'
  $agent_name     = $::fqdn
  $agent_port     = 21216

}
