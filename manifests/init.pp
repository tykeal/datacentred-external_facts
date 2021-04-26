# @summary Configure external_facts
#
# Defines an external fact directory structure and management policy
# and must be included in a catalog to use external_facts::fact
#
# Optionally, automatically configures external facts by setting the hiera
# structure of external_facts::external_facts
#
# @param facter_basedir
#   Sets the base directory for where facter looks for external facts
#   (default: /etc/puppetlabs/facter)
#
# @param facts_dir
#   Sets the subdirectory for where facts are loaded from
#   (default: "{lookup('external_facts::facter_basedir')}/facts.d)
#
# @param external_facts
#   A hash merged hash of facts to set as either boolean, or strings
#   (default: {})
#
# @param scripts
#   A hash merged hash of scripts to push out
#   (default: {})
#
# @example
#   include ::external_facts
#
class external_facts (
  Stdlib::Absolutepath $facter_basedir,
  Stdlib::Absolutepath $facts_dir,
  Hash[String, Struct[{value => Variant[Boolean, String]}]] $external_facts,
  Hash[String, Struct[{
    content => Optional[String],
    source  => Optional[Stdlib::Filesource],
  }]] $scripts,
) {

  File {
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { 'facter basedir':
    path =>  $facter_basedir,
  }

  -> file { 'facts dir':
    path    => $facts_dir,
    recurse => true,
    purge   => true,
  }

  $external_facts.each |String $resource, Hash $options| {
    external_facts::fact { $resource: * => $options }
  }

  $scripts.each |String $resource, Hash $options| {
    external_facts::script { $resource: * => $options }
  }
}
