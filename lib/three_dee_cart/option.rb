module ThreeDeeCart
  class Option < ThreeDeeCart::Root
    attr_accessor :id
    attr_accessor :option_type

    attr_reader :values

    def values=(value)

      if value.class.name != "Array"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Values", value.class])
      end

      @values = []
      if not value.nil?
        value.each do |key, val_obj|
          @values << ThreeDeeCart::Value.new(val_obj)
        end
      end

      @values
    end
  end
end