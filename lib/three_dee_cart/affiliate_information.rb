module ThreeDeeCart
  class AffiliateInformation < ThreeDeeCart::Root
    attr_accessor :affiliate_id
    attr_accessor :affiliate_commission
    attr_accessor :affiliate_approved
    attr_accessor :affiliate_approved_reason
  end
end