require File.dirname(__FILE__) + '/../test_helper'
require 'tree_display_controller'

# Re-raise errors caught by the controller.
class TreeDisplayController; def rescue_action(e) raise e end; end


class TreeDisplayControllerTest < ActionController::TestCase
  fixtures :users

  def test_goto_questionnaires
    goto_find('Questionnaires')
    assert_redirected_to :controller => 'tree_display', :action => 'list'
  end
end