# puppet-teamcity_agent

[![Build Status](https://travis-ci.org/jaxxstorm/puppet-teamcity_agent.svg?branch=master)](https://travis-ci.org/jaxxstorm/puppet-teamcity_agent)

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
2. [Setup - The basics of getting started with puppet-](#setup)
    * [What puppet-teamcity_agent affects](#what-puppet-teamcity_agent-affects)
    * [Beginning with puppet-teamcity_agent](#beginning-with-puppet-teamcity_agent)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)


## Module description

This module installs a teamcity agent. It makes the assumption you are only running one agent per host. It give you the option to install from a download url, or by downloading from a server url.

## Setup

### What puppet-teamcity_agent affects

Will ensure the teamcity agent is installed.
Will add a systemd unit file for the agent.
Will modify the config file for the agent


### Beginning with puppet-teamcity_agent

Simply include the teamcity_agent module like so:

```puppet
  include ::teamcity_agent
```

You may want to use a class include if you wish to override parameters:

```puppet
  class { '::teamcity_agent' :
		agent_port => 82122
  }
```

## Usage

### I just want to manage teamcity_agent, what's the minimum I need

```puppet
  include ::teamcity_agent
```

## Reference

### Classes

#### Public Classes
  * [`teamcity_agent`](#teamcity_agent): Installs and configures teamcity_agent in your environment.

#### Private Classes
  * [`teamcity_agent::install`]: Installs the required teamcity_agent
  * [`teamcity_agent::configure`]: Configures teamcity_agent's service and config file
  * [`teamcity_agent::service`]: Manages the teamcity_agent service
  

### `teamcity_agent`

#### Parameters

## Limitations

Currently only works on CentOS 7 or another systemd based operating system
