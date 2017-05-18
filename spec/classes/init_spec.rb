require 'spec_helper'

describe 'teamcity_agent' do

  RSpec.configure do |c|
    c.default_facts = {
      :architecture           => 'x86_64',
      :operatingsystem        => 'Ubuntu',
      :osfamily               => 'CentOS',
      :operatingsystemrelease => '7.2',
      :kernel                 => 'Linux',
      :fqdn                   => 'example-host',
    }
  end

  context "by default" do
    it { should compile.and_raise_error(/specify/) }
  end

  context "When installing via URL by default" do
    let(:params) {{
      :server_url => 'server-url',
    }}
    it { should contain_archive('/opt/teamcity/archives/BuildAgent.zip').with(:source => 'http://server-url/update/buildAgent.zip') }
    it { should contain_file('/opt/teamcity').with(:ensure => 'directory') }
    it { should contain_file('/opt/teamcity/archives').with(:ensure => 'directory') }
    it { should contain_file('/opt/teamcity').with(:ensure => 'directory') }
    it { should contain_service('teamcity-agent').with(:ensure => 'running', :enable => true) }
  end

  context "When installing via URL with a special archive_path" do
    let(:params) {{
      :server_url     => 'server-url',
      :archive_path   => '/usr/share/puppet-archive',
      :server_scheme  => 'https',
    }}
    it { should contain_archive('/usr/share/puppet-archive/BuildAgent.zip').with(:source => 'https://server-url/update/buildAgent.zip') }
    it { should contain_file('/usr/share/puppet-archive').with(:ensure => 'directory') }
  end

  context "When installing via URL by with a custom url" do
    let(:params) {{
      :download_url   => 'http://myurl/BuildAgent.zip',
    }}
    it { should contain_archive('/opt/teamcity/archives/BuildAgent.zip').with(:source => 'http://myurl/BuildAgent.zip') }
  end

  context "service should be installed" do
    let(:params) {{
      :server_url  => 'server-url',
    }}
    it { should contain_file('/lib/systemd/system/teamcity-agent.service').with_content(/ExecStart=\/opt\/teamcity\/BuildAgent\/bin\/agent.sh start/) }
    it { should contain_file('/lib/systemd/system/teamcity-agent.service').that_notifies('Exec[teamcity_agent-systemd-reload]') }
  end

  context "configuration file options" do
    let(:params) {{
      :server_url  => 'server-url:8111',
    }}
    it { should contain_file('/opt/teamcity/BuildAgent/conf/buildAgent.properties').with_content(/serverUrl=http:\/\/server-url:8111/)}
    it { should contain_file('/opt/teamcity/BuildAgent/conf/buildAgent.properties').with_content(/name=example-host/)}
    it { should contain_file('/opt/teamcity/BuildAgent/conf/buildAgent.properties').with_content(/ownPort=21216/)}
    it { should contain_file('/opt/teamcity/BuildAgent/conf/buildAgent.properties').with_content(/authorizationToken=test-token/)}
  end

  context "config with override" do
    let(:params) {{
      :server_url   	=> 'something',
			:server_scheme	=> 'https',
      :agent_name   	=> 'my-agent',
      :agent_port   	=> '8211',
      :extract_path 	=> '/usr/lib/teamcity',
			
    }}
		it { should contain_file('/usr/lib/teamcity/BuildAgent/conf/buildAgent.properties').with_content(/serverUrl=https:\/\/something/)}
    it { should contain_file('/usr/lib/teamcity/BuildAgent/conf/buildAgent.properties').with_content(/name=my-agent/)}
    it { should contain_file('/usr/lib/teamcity/BuildAgent/conf/buildAgent.properties').with_content(/ownPort=8211/)}
    it { should contain_file('/usr/lib/teamcity/BuildAgent/conf/buildAgent.properties').with_content(/authorizationToken=something-else/)}
  end


  context "configure service" do
    let(:params) {{
      :server_url    => 'something',

    }}
  end



end
