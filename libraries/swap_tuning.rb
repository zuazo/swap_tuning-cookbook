# encoding: UTF-8
#
# Cookbook Name:: swap_tuning
# Library:: swap_tuning
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

require 'chef/application'

class Chef
  # Methods to recommend swap sizes depending on memory values
  module SwapTuning
    SIZE_UNITS = {
      'GB' => 1_073_741_824,
      'MB' => 1_048_576,
      'KB' => 1024,
      'B'  => 1
    } unless defined?(::Chef::SwapTuning::SIZE_UNITS)

    def self.memory2bytes(memory)
      case memory.to_s
      when /^([0-9]+)([GMK]?B)$/i
        Regexp.last_match[1].to_i * SIZE_UNITS[Regexp.last_match[2].upcase]
      when /^([0-9]+)$/i then Regexp.last_match[1].to_i
      else fail "Unknown size: #{memory}"
      end
    end

    def self.memory2mbytes(memory)
      memory2bytes(memory).to_f / SIZE_UNITS['MB']
    end

    def self.memory2gbytes(memory)
      memory2mbytes(memory) / SIZE_UNITS['KB']
    end

    def self.unknown_size_check(memory)
      Chef::Log.warn(
        "RAM size too high (#{memory2gbytes(memory).round} GB), "\
        'I may not be able to choose the best swap size. Best size will be '\
        'workload dependent.'
      ) if memory > 68_719_476_736 # 64 GB
    end

    def self.recommended_size_bytes(memory)
      memory_b = memory2bytes(memory)
      unknown_size_check(memory_b)
      if memory_b <= 2_147_483_648 # 2 GB
        memory_b * 2
      elsif memory_b <= 8_589_934_592 # 8 GB
        memory_b
      else
        (memory_b.to_f / 2).ceil
      end
    end

    def self.recommended_size_mb(memory)
      bytes = recommended_size_bytes(memory)
      (bytes.to_f / 1_048_576).ceil
    end
  end
end
