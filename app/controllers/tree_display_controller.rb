class TreeDisplayController < ApplicationController
  helper :application
  # direct access to questionnaires

  def goto_find(s)
    node_object = TreeFolder.find_by_name(s)
    session[:root] = FolderNode.find_by_node_object_id(node_object.id).id
    redirect_to :controller => 'tree_display', :action => 'list'
  end

  def goto_questionnaires
    goto_find('Questionnaires')
  end
  
  # direct access to review rubrics
  def goto_review_rubrics
    goto_find('Review')
  end  
  
  # direct access to metareview rubrics
  def goto_metareview_rubrics
    goto_find('Metareview')
  end   
  
  # direct access to teammate review rubrics
  def goto_teammatereview_rubrics
    goto_find('Teammate Review')
  end   
  
  # direct access to author feedbacks
  def goto_author_feedbacks
   goto_find('Author Feedback')
  end  
  
  # direct access to global survey
  def goto_global_survey
    goto_find('Global Survey')
  end  
  
  # direct access to surveys
  def goto_surveys
    goto_find('Survey')
  end  
  
  # direct access to course evaluations
  def goto_course_evaluations
    goto_find('Course Evaluation')
  end    
  
  # direct access to courses
  def goto_courses
    goto_find('Courses')
  end
  
  # direct access to assignments
  def goto_assignments
    goto_find('Assignments')
  end  
  
  # called when the display is requested
  # ajbudlon, July 3rd 2008
  def list  
    if session[:display]      
      @sortvar = session[:display][:sortvar]
      @sortorder = session[:display][:sortorder]
      if session[:display][:check] == "1"
        @show = nil
      else
        @show = true
      end
    end
    if params[:display]      
      @sortvar = params[:display][:sortvar]
      @sortorder = params[:display][:sortorder] 
      if params[:display][:check] == "1"
        @show = nil
      else
        @show = true
      end
      session[:display] = params[:display]      
    end
  
    if session[:display].nil? and params[:display].nil?
      @show = true
    end
    
    if @sortvar == nil
      @sortvar = 'created_at'
    end
    if @sortorder == nil
      @sortorder = 'desc'
    end
        
    if session[:root]
      @root_node = Node.find(session[:root])
      @child_nodes = @root_node.get_children(@sortvar,@sortorder,session[:user].id,@show)
    else
      @child_nodes = FolderNode.get()
    end    
  end   
  
  def drill
    session[:root] = params[:root]
    redirect_to :controller => 'tree_display', :action => 'list'
  end
end
