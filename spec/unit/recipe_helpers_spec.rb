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
require 'support/fake_recipe'
require 'recipe_helpers'

describe Chef::SwapTuning::RecipeHelpers do
  subject { FakeRecipe.new }

  describe '#oldchef?' do

    {
      '11.10.4' => true,
      '11.12.0' => false
    }.each do |version, old|
      context "with Chef version #{version}" do
        before { stub_const('Chef::VERSION', version) }

        it "returns #{old}" do
          expect(subject.oldchef?).to eq(old)
        end
      end # context with Chef version version
    end # each version, old

  end # describe oldchef?

  describe '#ohai_memory_plugin_resource_name' do

    context 'with ChefSpec' do
      it 'returns no random number' do
        expect(subject.ohai_memory_plugin_resource_name)
          .to eq('reload_memory')
      end
    end # context with ChefSpec

    xcontext 'without ChefSpec' do
      it 'returns a random number'
    end # context without ChefSpec

  end # describe #ohai_memory_plugin_resource_name

  describe '#swap_size_mb' do
    before do
      allow(subject).to receive(:ohai_memory_reload)
      allow(Chef::SwapTuning).to receive(:memory2mbytes).and_return(100)
    end

    it 'calls #ohai_memory_reload' do
      expect(subject).to receive(:ohai_memory_reload).once
      subject.swap_size_mb
    end

    it 'calls SwapTuning#memory2mbytes' do
      expect(Chef::SwapTuning).to receive(:memory2mbytes).once.with('1048576kB')
      subject.swap_size_mb
    end

    it 'returns SwapTuning#memory2mbytes result' do
      allow(Chef::SwapTuning).to receive(:memory2mbytes).and_return(5)
      expect(subject.swap_size_mb).to eq(5)
    end
  end # describe #swap_size_mb

end
