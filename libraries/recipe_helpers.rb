# encoding: UTF-8
#
# Cookbook Name:: swap_tuning
# Library:: recipe_helpers
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

class Chef
  module SwapTuning
    # Some swap memory helpers to be included in Chef recipes
    module RecipeHelpers
      def chef_spec?
        !defined?(ChefSpec).nil?
      end

      def oldchef?
        Gem::Requirement.new('< 11.12')
          .satisfied_by?(Gem::Version.new(Chef::VERSION))
      end

      def ohai_memory_plugin_resource_name
        if chef_spec?
          'reload_memory'
        else
          # Avoid "cloning resource attributes from prior resource" warning
          rand = Random.rand
          "reload_memory (Avoid CHEF-3694: #{rand})"
        end
      end

      def ohai_memory_reload
        ohai ohai_memory_plugin_resource_name do
          plugin 'memory'
        end.run_action(:reload)
      end

      def swap_size_mb
        ohai_memory_reload
        size = node['memory']['swap']['total']
        Chef::SwapTuning.memory2mbytes(size).ceil
      end
    end
  end
end
