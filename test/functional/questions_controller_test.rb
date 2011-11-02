require File.dirname(__FILE__) + '/../test_helper'
require 'questions_controller'

# Re-raise errors caught by the controller.
class QuestionsController; def rescue_action(e) raise e end; end

class QuestionsControllerTest < ActionController::TestCase
  fixtures :users, :participants

  def setup
    @controller = QuestionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @request.session[:user] = User.find(users(:student1).id)
    AuthController.set_current_role(User.find(users(:student1).id).role_id,@request.session)
  end


end