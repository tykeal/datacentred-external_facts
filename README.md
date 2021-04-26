# external_facts

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Overview

[![Build Status](https://github.com/tykeal/puppet-external_facts/actions/workflows/pdk-tests.yaml/badge.svg)](https://github.com/tykeal/puppet-external_facts)
[![Puppet Forge](https://img.shields.io/puppetforge/v/tykeal/external_facts.svg)](https://forge.puppetlabs.com/tykeal/external_facts)

The external facts module is a simple wrapper around Facter 1.7+ support
for external facts.

This module is a fork of the
[datacentred/external_facts](https://github.com/datacentred/datacentred-external_facts)
module as Datacentred went out of business in 2017 and the module is now
effectively abandoned.

## Module Description

The external facts module installs supporting directory structures and creates
external facts on demand. These are defined on your hosts by puppet DSL and on
subsequent runs are sent to the master for use in manifest compilation. If the
fact definition is removed the fact is automatically purged and will become
absent in subsequent puppet runs.

## Usage

#### Enabling Support

Hosts must declare the directory management portion of the module if they want
non-existant facts to be purged and no facts are being pushed.

```puppet
include ::external_facts
```

NOTE: As long as there is at least one fact being created auto-purging of other
non-manged facts will occur even if the base class is not included

#### Creating facts

This can either be with an implicit value of true

```puppet
external_facts::fact { 'a_fact': }
```

or may be declared with an explicit value for use elsewhere

```puppet
external_facts::fact { 'servicegroups':
  value => 'http,https',
}
```

As of version 2.0 you may now define the facts as well as fact scripts via hiera
as follows:

```yaml
# define facts to be layed down
external_facts::external_facts:
    a_fact:
        value: true
    b_fact:
        value: http,https

# define scripts to be layed down
external_facts::scripts:
    "content-facts.sh":
        content: |
            #!/bin/bash
            echo FOO=bar
    "source-facts.sh":
        source: puppet:///modules/profile/facts/source-facts.sh
```

## Limitations

This module should work on all GNU Linux systems, but has only been tested on
Ubuntu and RedHat.

## Development

Development for this module is happening at
https://github.com/tykeal/puppet-external-facts

To contribute please open a Pull Request

A [DCO](https://developercertificate.org/) line indicated by a Signed-off-by in
the commit footer of _every_ commit of a patch series, not just your merge
request is _required_. If any of the commits in the series do not contain this,
the request will be rejected.

Pre-commit is used by this repository to enforce code cleanliness. Please make
sure you have installed it as well as the commit-msg hooks. If pre-commit
validation fails the PR will be rejected and only accepted after code changes as
amended updates (no add on fix-up commits that repair bad something that would
have been caught by pre-commit)
