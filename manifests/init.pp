# == Class: teamcity_agent
#
# === Parameters
#
# [*archive_path*]
#   Full path to store the zip file of the teamcity agent
#
# [*extract_path*]
#   Where to extract the zip file to
#
# [*download_url*]
#   A custom download url to grab the agent from
#
# [*server_url*]
#   The URL to download the teamcity agent zip file from
#
# [*server_scheme*]
#   Whether to use http or https for teamcity server
#
# [*agent_name*]
#   The name of the agent when registered in teamcity.
#   Defaults to fqdn
#
# [*agent_port*]
#   The port the agent should listen on
#
# [*agent_token*]
#   The auth token for the teamcity agent when registering
#   with the server
class teamcity_agent (
  $archive_path   = $teamcity_agent::params::archive_path,
  $extract_path   = $teamcity_agent::params::extract_path,
  $download_url   = undef,
  $server_url     = undef,
  $server_scheme  = $teamcity_agent::params::server_scheme,
  $agent_name     = $teamcity_agent::params::agent_name,
  $agent_port     = $teamcity_agent::params::agent_port,
  $agent_token     = undef,
) inherits teamcity_agent::params {

  $real_download_url = pick($download_url, "${server_scheme}://${server_url}/update/buildAgent.zip")

  if ! $download_url and ! $server_url {
    fail('Please specify a location to download teamcity agent from')
  }

  if ! $agent_token {
    fail('Please specify an authorization token for the agent')
  }


  anchor { 'teamcity_agent_first':}
  -> class { 'teamcity_agent::install': }
  class { 'teamcity_agent::configure':} ->
  #class { 'teamcity_agent::service': } ->
  anchor { 'teamcity_agent_final': }


}
