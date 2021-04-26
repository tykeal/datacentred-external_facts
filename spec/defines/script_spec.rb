# frozen_string_literal: true

require 'spec_helper'

describe 'external_facts::script' do
  let(:title) { 'namevar' }
  let(:params) do
    {}
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.not_to compile }

      it 'is expected not to compile with content and source defined' do
        params.merge!(
          {
            content: 'testing',
            source: 'file:///foo',
          },
        )

        is_expected.not_to compile
      end

      context 'with content set' do
        let(:params) do
          {
            content: 'testing',
          }
        end

        it { is_expected.to compile }
        it { is_expected.to contain_class('external_facts') }

        it {
          is_expected.to contain_file('/etc/puppetlabs/facter/facts.d/namevar').with(
            'owner'   => 'root',
            'group'   => 'root',
            'mode'    => '0550',
            'content' => 'testing',
          )
        }
      end

      context 'with source set' do
        let(:params) do
          {
            source: 'file:///foo',
          }
        end

        it { is_expected.to compile }

        it {
          is_expected.to contain_file('/etc/puppetlabs/facter/facts.d/namevar').with(
            'source' => 'file:///foo',
          )
        }
      end
    end
  end
end
