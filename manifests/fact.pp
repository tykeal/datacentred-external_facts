# @summary Set external facts
#
# Defines an external fact which will be available for use in your manifests
# next puppet run
#
# @param value
#   The value of the fact being set (default: true)
#
# @example
#   external_facts::fact { 'servicegroups':
#     value => 'http,https',
#   }
#
define external_facts::fact (
  Variant[Boolean, String] $value = true,
) {
  include external_facts

  file { "fact ${title}":
    ensure  => file,
    path    => "${external_facts::facts_dir}/${title}.txt",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "${title}=${value}",
    require => Class['external_facts'],
  }
}
