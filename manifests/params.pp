# == Class: external_facts::params
#
# Defines the common params used by Class[external_facts]
#
# === Authors
#
# Andrew J Grimberg <agrimberg@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2015 Andrew J Grimberg
#
class external_facts::params {
  if ($::is_pe or versioncmp($::puppetversion, '4.0.0') >= 0) {
    # PE and Puppet4+ use the same paths
    $facter_basedir = '/etc/puppetlabs/facter'
  }
  else {
    # All pre Puppet4+ FOSS distributions
    $facter_basedir = '/etc/facter'
  }

  $facts_dir = "${facter_basedir}/facts.d"
}
