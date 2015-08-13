require 'spec_helper'
describe 'external_facts::params' do
  # Testing this class doesn't matter if it's PE or not since we can't
  # inspect variables just manifest
  let(:facts) {
    {
      :is_pe => true
    }
  }

  context 'with defaults for all parameters' do
    it { should contain_class('external_facts::params') }
  end
end

# vim: ts=2 sw=2 sts=2 et :
