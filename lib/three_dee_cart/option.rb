module ThreeDeeCart
  class Option < ThreeDeeCart::Root
    attr_accessor :id
    attr_accessor :option_type

    attr_reader :values

    def values=(value)
      @values = []
      if not value.nil?
        value.each_pair do |key, val_obj|
          @values << ThreeDeeCart::Value.new(val_obj)
        end
      end

      @values
    end
  end
end