require 'test_helper'

class WeightTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Weight.new.valid?
  end
end
