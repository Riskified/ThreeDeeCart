class Hash
  def deep_find(key)
    if key?(key)
      return self[key]
    else
      self.values.each do |value|
        if value.respond_to?(:deep_find)
          return value.deep_find(key)
        end
      end
    end
  end
end