
class Chef
  module SwapTuning
    # Some swap memory helpers to be included in Chef recipes
    module RecipeHelpers
      def ohai_memory_reload
        ohai 'reload_memory' do
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
