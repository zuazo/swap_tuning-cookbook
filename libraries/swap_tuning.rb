
class Chef
  module SwapTuning

    # RedHat 7 Recommended Partitioning Scheme (2014-06-20):
    # https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Installation_Guide/sect-disk-partitioning-setup-x86.html#sect-recommended-partitioning-scheme-x86
    #
    # RAM             Recommended swap
    # =< 2 GB         2 x RAM
    # > 2 GB – 8 GB   = RAM
    # > 8 GB – 64 GB  0.5 x RAM
    # > 64 GB         workload dependent
    #
    # Ubuntu recommendations: https://help.ubuntu.com/community/SwapFaq#How_much_swap_do_I_need.3F
    #
    # TODO: consider the disk space?
    def self.recommended_size_bytes(memory)
      memory = case memory # get memory in bytes
      when /TB$/i
        memory.to_i * 1099511627776
      when /GB$/i
        memory.to_i * 1073741824
      when /MB$/i
        memory.to_i * 1048576
      when /KB$/i
        memory.to_i * 1024
      else
        memory
      end
      memory_gb = memory.to_f / 1073741824
      if memory_gb <= 2
        memory * 2
      elsif memory_gb <= 8
        memory
      elsif memory <= 64
        (memory.to_f / 2).ceil
      else
        Chef::Log.warn("RAM size too high (#{memory_gb.ceil} GB), I may not be able to choose the best swap size. Best size will be workload dependent.")
        (memory.to_f / 2).ceil
      end
    end

    def self.recommended_size_mb(memory)
      bytes = recommended_size_bytes(memory)
      (bytes.to_f / 1048576).ceil
    end

  end
end
