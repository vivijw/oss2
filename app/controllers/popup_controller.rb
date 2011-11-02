class PopupController < ApplicationController
  layout 'standard'

  def getscore(flag,s1, s2)
    @sum = 0
    @count = 0
    @maxscore = 0
    if(s2 == nil)
      @scores = nil
    else
    @reviewid = (Response.find_by_map_id(s2)).id
    @pid = ResponseMap.find(s2).reviewer_id
    @reviewer_id = Participant.find(@pid).user_id
    if(flag == 1)
      @assignment_id = ResponseMap.find(s2).reviewed_object_id
      @assignment = Assignment.find(@assignment_id)
      @participant = Participant.find(:first, :conditions => ["id = ? and parent_id = ? ", s1,@assignment_id])
    end

    @revqids = AssignmentQuestionnaires.find(:all, :conditions => ["assignment_id = ?",@assignment.id])
    @revqids.each do |rqid|
      rtype = Questionnaire.find(rqid.questionnaire_id).type
      if( rtype == 'ReviewQuestionnaire')
        @review_questionnaire_id = rqid.questionnaire_id
      end
    end
    if(@review_questionnaire_id)
      @review_questionnaire = Questionnaire.find(@review_questionnaire_id)
      @maxscore = @review_questionnaire.max_question_score
      @review_questions = @review_questionnaire.questions
    end
    if(flag == 0 && @maxscore == nil)
      @maxscore = 5
    end
    @scores = Score.find_all_by_response_id(@reviewid)
    @scores.each do |s|
      @sum = @sum + s.score
      #@temp = @temp + s.score
      @count = @count + 1
    end

    @sum1 = (100*@sum.to_f )/(@maxscore.to_f * @count.to_f)
#    @review_questionnaire = Questionnaire.find
#(@assignment.review_questionnaire_id)
#    @review_questions = @review_questionnaire.questions
#
    end
    return @sum, @maxscore, @sum1, @scores

  end

  def team_users_popup
    @teamid = params[:id]
    @team = Team.find(params[:id])
    @assignment = Assignment.find(@team.parent_id)
    @assignment_id = @assignment.id
    @teamusers = TeamsUser.find_all_by_team_id(params[:id])
    @sum, @maxscore, @sum1, @scores = getscore(0,params[:id1], params[:id2])
  end



  def participants_popup
    @participantid = params[:id]
    @uid = Participant.find(params[:id]).user_id
    @assignment_id =  Participant.find(params[:id]).parent_id
    @user = User.find(@uid)
    @myuser = @user.id
    @sum, @maxscore, @sum1, @scores = getscore(1, params[:id], params[:id2])
  end

  def view_review_scores_popup
    @reviewid = params[:id]
    @scores = Score.find_all_by_instance_id(@reviewid)
    
  end
  
  def reviewer_details_popup
    @userid = Participant.find(params[:id]).user_id
    @user = User.find(@userid)
  end

end
