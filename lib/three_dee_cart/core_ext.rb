class Hash

  def reverse_merge(other_hash = {})
    other_hash.each_pair do |k, v|
      unless self.has_key?(k)
        self[k] = v
      end
    end
    self
  end

  def deep_has_key?(key)
    self.has_key?(key) || any? {|k, v| v.deep_has_key?(key) if v.is_a? Hash}
  end

  def deep_find(key)
    self[key] || collect {|k,v| v.deep_find(key) if v.is_a? Hash}.first
  end

  alias :deep_include? :deep_has_key?
  alias :deep_key? :deep_has_key?
  alias :deep_member? :deep_has_key?
  
  def deep_has_value?(value)
    self.has_value?(value) || any? {|k,v| v.deep_has_value?(value) if v.is_a? Hash}
  end
  alias :deep_value? :deep_has_value?
end