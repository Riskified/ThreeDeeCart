module ThreeDeeCart
  class CustomerData < ThreeDeeCart::Root

    module Exceptions
      class QueryConversionError < StandardError; end
    end

    include ActiveModel::Validations

    AVAILABLE_ACTIONS = [:insert, :delete, :update]

    attr_accessor :action

    attribute_accessor :contactid,
                  :alt_contactid,
                  :billing_firstname,
                  :billing_lastname,
                  :billing_address,
                  :billing_address2,
                  :billing_city,
                  :billing_state,
                  :billing_zip,
                  :billing_country,
                  :billing_company,
                  :billing_phone,
                  :email,
                  :shipping_firstname,
                  :shipping_lastname,
                  :shipping_address,
                  :shipping_address2,
                  :shipping_city,
                  :shipping_state,
                  :shipping_zip,
                  :shipping_country,
                  :shipping_company,
                  :shipping_phone,
                  :comments,
                  :website,
                  :pass,
                  :discount,
                  :accountno,
                  :maillist,
                  :custenabled,
                  :addtional_field1,
                  :addtional_field2,
                  :addtional_field3

    validates :contactid, presence: true
    validates :action, inclusion: { in: AVAILABLE_ACTIONS }

    validates :billing_firstname, :billing_lastname, :email, :pass, presence: true, if: Proc.new {|me| me.insert? }

    def initialize(attrs_hash = {})
      super

      # Apply defaults according to the API.
      @discount ||= 0
      @custenabled ||= 0
      @maillist ||= 0
    end

    def insert?
      self.action == :insert
    end

    def update?
      self.action == :update
    end

    def delete?
      self.action == :delete
    end

    def to_query
      if !(self.valid?)
        raise(ThreeDeeCart::CustomerData::Exceptions::QueryConversionError, "Could not convert invalid CustomerData to query: #{self.errors.full_messages.inspect}")
      else
        self.attributes.inspect
      end
    end
  end
end