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

describe Chef::SwapTuning do

  describe '#memory2bytes' do

    {
      '256'   => 256,
      '256KB' => 256 * KB,
      '256MB' => 256 * MB,
      '256GB' => 256 * GB
    }.each do |memory, bytes|

      it "converts #{memory} to #{bytes}" do
        expect(described_class.memory2bytes(memory)).to eq(bytes)
      end

    end

    it 'does not convert unknown memory values' do
      expect { described_class.memory2bytes('256BAD') }
        .to raise_error(/^Unknown size: /)
    end

  end # describe #memory2bytes

  describe '#recommended_size_bytes' do

    {
      '256MB'  => 512 * MB,
      '512MB'  => 1024 * MB,
      1.9 * GB => 2 * 1.9 * GB,
      2.1 * GB => 2.1 * GB,
      '4GB'    => 4 * GB,
      7.9 * GB => 7.9 * GB,
      8.1 * GB => 8.1 * GB / 2,
      '10GB'   => 5 * GB,
      '100GB'  => 50 * GB
    }.each do |memory, swap|
      memory = memory.is_a?(Numeric) ? memory.round : memory
      swap = swap.floor

      it "recommends #{swap} swap size with #{memory} memory" do
        allow(Chef::Log).to receive(:warn)
        swap_diff = described_class.recommended_size_bytes(memory) - swap
        expect(swap_diff.abs).to be < 5
      end

      if described_class.memory2bytes(memory) <= 64 * GB

        it "warns if #{memory} RAM size is not too high" do
          expect(Chef::Log).not_to receive(:warn)
          described_class.recommended_size_bytes(memory)
        end

      else

        it "does not warn if #{memory} RAM size is too high" do
          expect(Chef::Log).to receive(:warn).once
          described_class.recommended_size_bytes(memory)
        end

      end

    end # each do memory, swap

  end # describe recommended_size_bytes

  describe '#recommended_size_mb' do

    it 'returns #recommended_size_bytes result in MB' do
      memory = 4 * GB
      expect(described_class).to receive(:recommended_size_bytes).once
        .with(memory).and_return(memory)
      expect(described_class.recommended_size_mb(memory))
        .to eql(memory / (1024 * 1024).ceil)
    end

  end # describe #recommended_size_mb

end
