require 'test_helper'

module Administrate
  class DefaultOrderTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Administrate::DefaultOrder::VERSION
    end
  end
end
