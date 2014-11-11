module ActsAsTenant
  module HelperExtensions
    def without_tenant(&block)
      if block.nil?
        raise ArgumentError, "block required"
      end

      ActsAsTenant.original_tenant = ActsAsTenant.current_tenant
      ActsAsTenant.current_tenant = nil
      value = block.call
      return value

    ensure
      ActsAsTenant.current_tenant = ActsAsTenant.original_tenant
      ActsAsTenant.original_tenant = nil
    end
  end
end