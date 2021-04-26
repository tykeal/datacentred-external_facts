require 'spec_helper'
describe 'external_facts' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'default' do
        it { is_expected.to compile }

        it {
          is_expected.to contain_file('facter basedir').with(
            'path' => '/etc/puppetlabs/facter',
          )
        }

        it {
          is_expected.to contain_file('facts dir').with(
            'path'    => '/etc/puppetlabs/facter/facts.d',
            'recurse' => true,
            'purge'   => true,
          )
        }
      end

      context 'with external_facts set' do
        let(:params) do
          {
            external_facts: {
              test1: {
                value: true,
              },
              test2: {
                value: 'testing',
              }
            }
          }
        end

        it { is_expected.to contain_external_facts__fact('test1') }
        it {
          is_expected.to contain_file('fact test1').with(
            'content' => 'test1=true',
          )
        }

        it { is_expected.to contain_external_facts__fact('test2') }
        it {
          is_expected.to contain_file('fact test2').with(
            'content' => 'test2=testing',
          )
        }
      end

      context 'with scripts set' do
        let(:params) do
          {
            scripts: {
              'content-facts.sh': {
                content: 'foo',
              },
              'source-facts.sh': {
                source: 'file:///foo-facts.sh',
              },
            }
          }
        end

        it { is_expected.to contain_external_facts__script('content-facts.sh') }
        it {
          is_expected.to contain_file('/etc/puppetlabs/facter/facts.d/content-facts.sh').with(
            'content' => 'foo',
          )
        }

        it { is_expected.to contain_external_facts__script('source-facts.sh') }
        it {
          is_expected.to contain_file('/etc/puppetlabs/facter/facts.d/source-facts.sh').with(
            'source' => 'file:///foo-facts.sh',
          )
        }
      end
    end
  end
end
