************************************************************************************************************
     	517 projectE219: Miscellaneous controller cleanup

************************************************************************************************************
Team: OSS_projects_WH
Members: Wei Jia (wjia), Huijun Zhang (hzhang12)

************************************************************************************************************
We have modified some controllers, and add functional test for each controller that we modified. Controllers 
we have worked on:

1. pg_users_controller
2. popup_controller
3. profile_controller
4. publishing_controller
5. questions_controller
6. reports_controller
7. roles_controller
8. roles_permissions_controller
9. site_controllers_controller
10. statistics_controller
11. student_team_controller
12. suggestion_controller
13. survey_controller
14. survey_deployment_controller
15. survey_response_controller
16. system_settings_controller
17. teams_users_controller
18. tree_display_controller
19. users_controller
20. waitlists_controller

************************************************************************************************************
Modification on controllers we have done:

1. pg_users_controller
The class PgUsersController is inherited from UsersController. There are two methods "create" and "remove_user" 
in pg_users_controller.

These two methods are not called by any models or views. As a result, we think these code can be deleted.?
This method creates an entry in the users table.  It is caled from the Add Super-Admin, Add Administrator, 
Add Instructor, and Add Student functions. The parent field identifies the entity in the users table (e.g.,
 an instructor) that created this entry (e.g., a student).

------------------------------------------------------------------------------------------------------------   
2. popup_controller
There are four methods, team_users_popup, participants_popup, view_review_scores_popup, and reviewer_details 
popup. Each one of them has its own view page. 

view_review_scores_popup is not called anywhere, so it can't be viewed. The code can be deleted.
Other 3 methods are called by views/review_mapping/_report.html.erb. They can be viewed by 
http://localhost:3000/review_mapping/review_report/267(or 268).

In popup_controller.rb, we found that there are code duplications in team_users_popup and particapants_popup.
We merge the code into one function, and make two methods call the same function.

------------------------------------------------------------------------------------------------------------ 
3. profile_controller
There are two methods in profile_controller, "edit" and "update". They are called by view/profile/edit.html.erb
and can be viewed by http://localhost:3000/profile/edit.

Everything looks fine. We didn't modify anything.

------------------------------------------------------------------------------------------------------------ 
4. publishing_controller
There are four methods in publishing_controller, view, set_publish_permission, update_publish_permission, grant
and grant_with_private_key. view, set_publish_permission, update_publish_permission and grant are called by 
view/publishing/view.html.erb. grant_with_private_key is called by view/publishing/grant.html.erb. They can
be veiwed by http://localhost:3000/publishing/grant(view).

Everything looks fine. We didn't modify anything.

------------------------------------------------------------------------------------------------------------ 
5. questions_controller

create and update methods code reuse.

------------------------------------------------------------------------------------------------------------ 
6. reports_controller

Only one method "view". It looks fine.

------------------------------------------------------------------------------------------------------------ 
7. roles_controller

create and update methods code reuse.

------------------------------------------------------------------------------------------------------------ 
8. roles_permissions_controller

create and update methods code reuse.

------------------------------------------------------------------------------------------------------------ 
9. site_controllers_controller

create and update methods code reuse.

------------------------------------------------------------------------------------------------------------ 
10. statistics_controller
It can be viewed by http://localhost:3000/statistics/list, but the view_response and list_survey pages cannot 
display.

view_responses method inside code reuse! I defined cal_resopnse() for each calculation of responses.

------------------------------------------------------------------------------------------------------------ 
11. student_team_controller

create and update methods code reuse.

------------------------------------------------------------------------------------------------------------ 
12. suggestion_controller

All the method defined in the suggestion_controller are actions and has corresponding html file in the view 
or called in some of the html file. And it doesn't exhibit code redundant here, so we didn't modify it. 

------------------------------------------------------------------------------------------------------------
13. survey_controller

There is noting to change in the survey controller, only one method, assign, is defined in the controller, 
and it has the corresponding html file, however, in the view for the survey, there is also a file called 
list.html.erb, it is completely the same with assign.html.erb, so I think it could be deleted. 

------------------------------------------------------------------------------------------------------------
14. survey_deployment_controller

(1).move the add method in survey_development_controller to the survey_development model. The method should 
not be in the controller, it doesn’t mean an action, and there is no corresponding html file in the view for
survey_development. 

(2).Make some code change:
i> @survey_deployment.course_evaluation_id = 27 (I'm not sure whether it's correct here to give the 
course-evaluation_id = 27, withouth given the value, error will be reported as there is no place that give 
the value for the variable course_evaluation_id)

ii>@course=Course.find_all_by_instructor_id(session[:user].id).map{|u|[u.name,   u.id] }, change u.title 
to u.name, there is no column called title in the table for course. 

------------------------------------------------------------------------------------------------------------
15. survey_response_controller

We didn't find any redundant code here, so it's fine here and we didn't make any change. 

------------------------------------------------------------------------------------------------------------
16. system_settings_controller

For system setting, the only change that should be done is perhaps to move the foreign method foreign to the
model of System Setting. However, I didn’t make the change here, the definition of the method foreign reduce 
the redundant of defining the same variables, so I thinks it’s proper here.

------------------------------------------------------------------------------------------------------------
17.  teams_users_controller

There is no redundant here and all the methods defined in the controller have corresponding html file in the 
view, they are all absolutely actions, so it's fine to define them in the controller. 

------------------------------------------------------------------------------------------------------------
18.  tree_display_controller

I define a new method called goto_find(s) to reduce the redundant code in the controller.
  def goto_find(s)
    node_object = TreeFolder.find_by_name(s)
    session[:root] = FolderNode.find_by_node_object_id(node_object.id).id
    redirect_to :controller => 'tree_display', :action => 'list'
  end


------------------------------------------------------------------------------------------------------------
19. users_controller

It's fine for users_controller. We didn't find any code redundant part. All the functions defined in the 
controller are actions and have corresponding html file in the view except two methods, get_role and foreign, 
however the two methods are private and protected, so we think it's ok to leave them in the controller and 
they also exhibit code reuse, so it's fine here. 

------------------------------------------------------------------------------------------------------------
20.  waitlists_controller

There is no change need to be done for the controller. 

************************************************************************************************************
We have added one functional test file for each controller that we modified, and one test case for each
method that we added, as shown in the code in test/functional folder. 

All tests have passed.

************************************************************************************************************Expertiza
=========

#### Peer review system

Expertiza is a web application where students can submit and peer-review learning objects (articles, code, web sites, etc). It is used in select courses at NC State and by professors at several other colleges and universities.

Setup
-----

### NCSU VCL image

The expertiza environment is already set up in [NC State's VCL](https://vcl.ncsu.edu) image "Ruby on Rails".
If you have access, this is quickest way to get a development environment running for Expertiza.

If not:

### Tools

 * [Set up git](http://help.github.com/set-up-git-redirect)
 * Install Ruby 1.8.7. (Ruby 1.9.2 may work but hasn't been tested)
   Use [rvm](http://beginrescueend.com) on Linux/OSX, or [RailsInstaller](http://railsinstaller.org) on Windows
 * `gem install bundler` (see [issues on Windows](http://matt-hulse.com/articles/2010/01/30/from-zero-to-rails3-on-windows-in-600-seconds/))

### Dependencies

 * libxslt development libraries [OSX: (already installed?) Ubuntu: `sudo apt-get install libxslt-dev` Fedora: `yum install libxslt-devel` Windows: ?]
 * (optional) [graphviz](http://www.graphviz.org)
 * bundled gems: `bundle install`
 
 If anything is missing here, please report it in an issue or fix it in a pull request. Thanks!

Contributing
------------

 * [Fork](http://help.github.com/fork-a-repo/) the expertiza project
 * [Create a new branch](http://progit.org/book) for your contribution with a descriptive name
 * [Commit and push](http://progit.org/book) until you are happy with your contribution - follow the style guidelines below
 * Make sure to add tests for it; the tests should fail before your contribution/fix and pass afterward
 * [Send a pull request](http://help.github.com/send-pull-requests) to have your code reviewed for merging back into Expertiza

Style Guidelines
----------------

We've had many contributors in the past who have used a wide variety of ruby coding styles. It's a mess, and we're trying to unify it.

All new files/contributions should:

 * Use unix line endings (Windows users: configure git to use [autocrlf](http://help.github.com/line-endings))
 * Indent with 2 spaces (no tabs; configure your editor) both in ruby and erb
 * Follow the [Ruby Style Guide](http://batsov.com/Programming/Ruby/2011/09/12/ruby-style-guide.html) style for syntax, formatting, and naming

When editing existing files:

 * Keep the existing tabbing (use tabs instead of spaces in files that already use tabs everywhere; otherwise use spaces)
 * Keep the existing line ending style (dos/unix)
 * Follow the Ruby style Guide on code you add or edit, as above

Please do no go crazy changing old code to match these guidelines; it will just create lots of potential merge conflicts.
Applying style guidelines to code you add and modify is good enough. :-)
