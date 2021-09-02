module Buildable
  def self.not_provided
    @@not_provided ||= Object.new
  end

  def buildable_with(*attrs)
    attrs.each do |attr|
      define_method attr do |value = Buildable.not_provided, &block|
        if value === Buildable.not_provided && block.nil?
          result = instance_variable_get("@#{attr}")
          result.is_a?(Proc) ? instance_eval(&result) : result
        else
          instance_variable_set("@#{attr}", block || value)
        end
      end
    end

    attr_writer *attrs
  end
end