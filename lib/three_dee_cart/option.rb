=begin
Represents the 3D Cart Option response object
=end
module ThreeDeeCart
  class Option < ThreeDeeCart::Root
    attr_accessor :id
    attr_accessor :option_type

    attr_reader :values

    # Custom getter for values, returns a ThreeDeeCart::Value set
    def values=(value)
      if value.class.name != "Hash" || !value.keys.include?(:value)
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Values", value.class])
      end

      value_obj = value[:value]
      @values = []

      if value_obj.class.name == "Hash"
        @values << ThreeDeeCart::Value.new(value_obj)
      elsif value_obj.class.name == "Array"
        if not value_obj.nil?
          value_obj.each do |val_obj|
            @values << ThreeDeeCart::Value.new(val_obj)
          end
        end
      else
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Values", value_obj.class])
      end

      @values
    end
  end
end