# @summary Manage external fact scripts
#
# Provide an easy mechanism for putting external fact scripts into place
#
# @param content
#   The content that should be put into the script file. Conflicts with source
#   parameter.
#
# @param source
#   A filesource URL to be used for the content of the file to be placed.
#   Conflicts with the content parameter
#
# @example
#   external_facts::script { 'facts.sh':
#     source  => 'puppet:///modules/profile/facts/facts.sh',
#   }
#
# @example
#   external_facts::script { 'facts.sh':
#     content =>  '#!/bin/bash
#       echo FOO=BAR
#     ',
#   }
#
define external_facts::script (
  Optional[String] $content = undef,
  Optional[Stdlib::Filesource] $source = undef,
) {
  include external_facts

  # Fail if we don't have content or source
  if !$content and !$source {
    fail('content or source must be set')
  }

  # Fail is we have both content and source
  if $content and $source {
    fail('either content or source must be set, but not both')
  }

  file { "${external_facts::facts_dir}/${title}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    content => $content,
    source  => $source,
  }
}
