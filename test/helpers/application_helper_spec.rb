require 'test_helper'

class ApplicationHelper < ActionView::TestCase
  test "should return base title without arguements" do
    assert_equal full_title, 'BDAdb'
  end
end