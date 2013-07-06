require 'spec_helper'
# require the helper module

describe Threedeecart::Base do
  include Savon::SpecHelper

  before(:all) { savon.mock!   }
  after(:all)  { savon.unmock! }

end