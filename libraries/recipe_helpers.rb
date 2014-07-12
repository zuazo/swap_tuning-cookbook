
class Chef
  module SwapTuning
    module RecipeHelpers

      def ohai_memory_reload
        ohai 'reload_memory' do
          plugin 'memory'
        end.run_action(:reload)
      end

      def swap_size_mb
        ohai_memory_reload
        size = node['memory']['swap']['total']
        case size.to_s
        when /^([0-9]+)GB$/i
          $1.to_i * 1024
        when /^([0-9]+)MB$/i
          $1.to_i
        when /^([0-9]+)KB$/i
          $1.to_i / 1024
        when /^([0-9]+)B?$/i
          $1.to_i / 1048576
        when nil
          0
        else
          Chef::Application.fatal!("Unknown swap size: #{size}")
        end.ceil
      end

    end
  end
end
