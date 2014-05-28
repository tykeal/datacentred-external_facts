datacentred-external_facts
==========================

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Testing - Guide for contributing to the module](#testing)

## Overview

The external facts module is a simple wrapper around Facter 1.7+ support
for extenal facts.

## Module Description

The external facts module installs supporting directory structures and
creates external facts on demand.  These are defined on your hosts by
puppet DSL and on subsequent runs are sent to the master for use in
manifest compilation.  If the fact definition is removed the fact is
automatically purged and will become absent in subsequent puppet runs.

## Usage

#### Enabling Support

Hosts must declare the directory management portion of the module

    import ::external_facts

#### Creating facts

This can either be with an implicit value of true

    external_facts::fact { 'a_fact': }

or may be declared with an explicit value for use elsewhere

    external_facts::fact { 'servicegroups':
      value => 'http,https',
    }

## Limitations

This module should work on all GNU Linux systems, but has only been tested
on Ubuntu.

Puppet Enterprise deployments are not supported at present.

## Testing

There is no unit testing provided.
