module ActsAsTenant
  module HelperExtensions
    def without_tenant(&block)
      if block.nil?
        raise ArgumentError, "block required"
      end

      # if original_tenant is nil, assume we are not already in a without_tenant block
      # possible value is nil AND we're in a block if ActsAsTenant.current_tenant was nil, but that shouldn't matter since everything stays nil
      if ActsAsTenant.original_tenant.nil?
        ActsAsTenant.original_tenant = ActsAsTenant.current_tenant
        ActsAsTenant.current_tenant = nil
      else
        within_block = true
      end

      block.call
    ensure
      unless within_block
        ActsAsTenant.current_tenant = ActsAsTenant.original_tenant
        ActsAsTenant.original_tenant = nil
      end
    end
  end
end