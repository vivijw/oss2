require File.dirname(__FILE__) + '/../test_helper'
require 'popup_controller'

# Re-raise errors caught by the controller.
class PopupController; def rescue_action(e) raise e end; end

class PopupControllerTest < ActionController::TestCase
  fixtures :users, :participants

  def setup
    @controller = PopupController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @request.session[:user] = User.find(users(:student1).id)
    AuthController.set_current_role(User.find(users(:student1).id).role_id,@request.session)
  end


end