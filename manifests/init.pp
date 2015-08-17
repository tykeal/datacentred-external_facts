# == Class: external_facts
#
# Defines an external fact directory structure and management policy
# and must be included in a catalog to use external_facts::fact
#
# === Examples
#
# include ::external_facts
#
class external_facts inherits external_facts::params {

  File {
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { 'facter basedir':
    path =>  $external_facts::params::facter_basedir,
  } ->

  file { 'facts dir':
    path    => $external_facts::params::facts_dir,
    recurse => true,
    purge   => true,
  }
}
