require 'tracker_api'
require 'git'

module Pivotal_Hub
 class Story
  attr_reader :client, :project, :git

  def initialize
   if File.exists?('.git')
    @git = Git.open(Dir.pwd)
  	@client = TrackerApi::Client.new(token: @git.config('pivotal.api-token'))
  	@project  = client.project(@git.config('pivotal.project-id'))
   else
    puts "Ops, you are not in git directory!"
    exit
   end
  end

  def update_state story_id, state
  	story = @project.story(story_id)
  	story.current_state = state
  	story.save
    story
  end

  def get_current_branch
     @git.current_branch
  end
  
  end
end

