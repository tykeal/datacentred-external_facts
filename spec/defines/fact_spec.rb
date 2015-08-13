require 'spec_helper'
describe 'external_facts::fact', :type => :define do
  # We've tested that the facts.d gets set correctly in the init_spec so
  # we'll only test the resultant path on a FOSS Puppet < 4 configuration
  let(:facts) {
    {
      :is_pe         => false,
      :puppetversion => '2.7.1',
    }
  }
  let(:title) { 'testing' }

  context 'with defaults for all parameters' do
    let (:params) {{}}

    it { should contain_class('external_facts') }

    it { should contain_file('fact testing').with(
      'ensure'  => 'file',
      'path'    => '/etc/facter/facts.d/testing.txt',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0644',
      'content' => 'testing=true',
    ) }
  end
end

# vim: ts=2 sw=2 sts=2 et :

