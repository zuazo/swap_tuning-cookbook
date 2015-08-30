# encoding: UTF-8
#
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require_relative '../spec_helper'
require 'swap_tuning'

describe 'swap_tuning::default', order: :random do
  let(:chef_runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { chef_runner.converge(described_recipe) }
  let(:node) { chef_runner.node }
  before do
    node.automatic['memory']['total'] = '524288kB'
    node.automatic['memory']['swap']['total'] = '0kB'
  end

  (0..9).step.each do |i|
    it "creates swapfile#{i}" do
      expect(chef_run).to create_swap_file("/swapfile#{i}")
    end
  end

  it 'does not create swapfile10' do
    expect(chef_run).to_not create_swap_file('/swapfile10')
  end

  shared_examples_for 'a machine in need of swap' do |memory|
    before do
      node.automatic['memory']['total'] = memory[:memory]
      node.automatic['memory']['swap']['total'] = memory[:current_swap]
    end

    if memory[:new_swap] > 0
      it 'reloads ohai memory plugin' do
        expect(chef_run).to reload_ohai('reload_memory').with(
          plugin: 'memory'
        ).at_compile_time
      end

      it "creates a swap file of #{memory[:new_swap]} MB" do
        expect(chef_run).to create_swap_file('/swapfile0').with(
          size: memory[:new_swap]
        )
      end

    else # memory[:new_swap] <= 0

      it 'does not create a swap file' do
        expect(chef_run).to_not create_swap_file('/swapfile0')
      end

    end # if memory[:new_swap] <= 0
  end # shared_examples_for a machine in need of swap

  describe 'with 1 GB memory and 0 GB swap' do
    it_should_behave_like 'a machine in need of swap',
                          memory: system_memory(1 * GB),
                          current_swap: 0,
                          new_swap: swap_file_size(2 * GB)
  end

  describe 'with 3 GB memory and 1 GB swap' do
    it_should_behave_like 'a machine in need of swap',
                          memory: system_memory(3 * GB),
                          current_swap: system_swap(1 * GB),
                          new_swap: swap_file_size(2 * GB)
  end

  describe 'with 3 GB memory and 3 GB swap' do
    it_should_behave_like 'a machine in need of swap',
                          memory: system_memory(3 * GB),
                          current_swap: system_swap(3 * GB),
                          new_swap: 0
  end

  describe 'with 3 GB memory and 4 GB swap' do
    it_should_behave_like 'a machine in need of swap',
                          memory: system_memory(3 * GB),
                          current_swap: system_swap(4 * GB),
                          new_swap: 0
  end
end
