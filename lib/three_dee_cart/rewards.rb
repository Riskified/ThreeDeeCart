=begin
Represents the 3D Cart Rewards response object
=end
module ThreeDeeCart
  class Rewards < ThreeDeeCart::Root
    attr_accessor :reward_points
    attr_accessor :reward_disable
    attr_accessor :reward_redeem
  end
end