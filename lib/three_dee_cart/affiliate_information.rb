=begin
Represents the 3D Cart Address affiliate information object
=end
module ThreeDeeCart
  class AffiliateInformation < ThreeDeeCart::Root
    attr_accessor :affiliate_id
    attr_accessor :affiliate_commission
    attr_accessor :affiliate_approved
    attr_accessor :affiliate_approvedreason
  end
end