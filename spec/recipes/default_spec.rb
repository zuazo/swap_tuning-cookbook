# encoding: UTF-8
#
# Author:: Xabier de Zuazo (<xabier@onddo.com>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL. (www.onddo.com)
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

require 'spec_helper'
require 'swap_tuning'

describe 'swap_tuning::default' do

  shared_examples_for 'a machine in need of swap' do |memory|
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['memory']['total'] = memory[:memory]
        node.set['memory']['swap']['total'] = memory[:current_swap]
      end.converge(described_recipe)
    end

    if memory[:new_swap] > 0
      it 'should reload ohai memory plugin' do
        expect(chef_run).to reload_ohai('reload_memory').with(
          plugin: 'memory'
        ).at_compile_time
      end

      it "should create a swap file of #{memory[:new_swap]} MB" do
        expect(chef_run).to create_swap_file('/swapfile0').with(
          size: memory[:new_swap]
        )
      end

    else # memory[:new_swap] <= 0

      it "should not create a swap file" do
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

  describe 'with 501832KB memory and 0KBI swap' do
    it_should_behave_like 'a machine in need of swap',
                          memory: '501832KB',
                          current_swap: '0KBI',
                          new_swap: swap_file_size(1004544 * KB)
  end

  describe 'with 501832KB memory and 10045400KBI swap' do
    it_should_behave_like 'a machine in need of swap',
                          memory: '501832KB',
                          current_swap: '1004540KBI',
                          new_swap: 0
  end

end
