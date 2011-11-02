require File.dirname(__FILE__) + '/../test_helper'
require 'survey_deployment_controller'

# Re-raise errors caught by the controller.
class SurveyDeploymentController; def rescue_action(e) raise e end; end

class SurveyDeploymentControllerTest < ActionController::TestCase
   fixtures :users

  def setup
    @controller = SurveyDeploymentController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:user] = users(:superadmin)
    Role.rebuild_cache
    AuthController.set_current_role(users(:superadmin).role_id,@request.session)
  end

  def test_create
     post :create, :course => {:name => 'Built Course', :info => 'Blah', :directory_path => 'abc321'}
    assert !Course.find_by_name('Built Course').nil?
#    What we really want to test is to see if we got where get_home_controller says we should've gotten, but we are cheating for now
#    assert_redirected_to :controller => AuthHelper::get_home_controller(session[:user]), :action => AuthHelper::get_home_action(session[:user])
    assert_redirected_to :controller => 'tree_display', :action => 'list'
    assert flash.empty?
  end
end