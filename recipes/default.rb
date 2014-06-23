#
# Cookbook Name:: swap_tuning
# Recipe:: default
#
# Copyright 2014, Onddo Labs, Sl.
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

def ohai_memory_reload
  ohai 'reload_memory' do
    plugin 'memory'
  end.run_action(:reload)
end

def swap_size_mb
  ohai_memory_reload
  size = node['memory']['swap']['total']
  case size
  when /^([0-9]+)GB$/i
    $1.to_i * 1024
  when /^([0-9]+)MB$/i
    $1.to_i
  when /^([0-9]+)KB$/i
    $1.to_i / 1024
  when /^([0-9]+)B?$/i
    $1.to_i / ( 1024 * 1024 )
  else
    Chef::Application.fatal!("Unknown swap size: #{size}")
  end.ceil
end

unless node['swap_tuning']['file_prefix'].nil?

  # Calculate swap size
  if node['swap_tuning']['size'].nil?
    node.default['swap_tuning']['size'] = Chef::SwapTuning.recommended_size_mb(node['memory']['total'])
    unless node['swap_tuning']['minimum_size'].nil?
      if node['swap_tuning']['size'] < node['swap_tuning']['minimum_size']
        node.default['swap_tuning']['size'] = node['swap_tuning']['minimum_size']
      end
    end
  end

  i = 0
  current_size = swap_size_mb
  while current_size + 10 < node['swap_tuning']['size'] and i < 10 # margin of 10 MB
    remaining_size = node['swap_tuning']['size'] - current_size

    swap_file "#{node['swap_tuning']['file_prefix']}#{i}" do
      size remaining_size # MBs
      not_if do ::File.exists?("#{node['swap_tuning']['file_prefix']}#{i}") end # not required
    end.run_action(:create)

    i += 1
    current_size = swap_size_mb
  end

end
