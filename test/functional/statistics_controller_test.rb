require File.dirname(__FILE__) + '/../test_helper'
require 'statistics_controller'

# Re-raise errors caught by the controller.
class StatisticsController; def rescue_action(e) raise e end; end

class StatisticsControllerTest < ActionController::TestCase
  fixtures :users, :roles, :participants

  def setup
    @controller = StatisticsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @request.session[:user] = User.find(users(:student1).id)
    AuthController.set_current_role(User.find(users(:student1).id).role_id,@request.session)
  end

  def test_view_responses
    post :login, :login => {:name => users(:admin).name, :password => users(:password).name}
    #assert_redirected_to :controller => StatisticsHelper::get_home_controller(session[:user]), :action => StatisticsHelper::get_home_action(session[:user])
    assert_redirected_to :action => 'view_responses'
  end


end