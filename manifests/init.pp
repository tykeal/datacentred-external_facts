# == Class: external_facts
#
# Defines an external fact directory structure and management policy
# and must be included in a catalog to use external_facts::fact
#
# === Examples
#
# include ::external_facts
#
class external_facts {

  File {
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/facter':
  } ->

  file { '/etc/facter/facts.d':
    recurse => true,
    purge   => true,
  }

}
