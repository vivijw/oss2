require File.dirname(__FILE__) + '/../test_helper'
require 'roles_permissions_controller'

# Re-raise errors caught by the controller.
class RolesPermissionsController; def rescue_action(e) raise e end; end

class RolesPermissionsControllerTest < ActionController::TestCase
  fixtures :users, :roles, :participants

  def setup
    @controller = RolesPermissionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @request.session[:user] = User.find(users(:student1).id)
    AuthController.set_current_role(User.find(users(:student1).id).role_id,@request.session)
  end


end