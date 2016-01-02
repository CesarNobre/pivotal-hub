require 'tracker_api'

module Pivotal_Hub
 class Story
  attr_reader :client, :project 

  def initialize
  	@client = TrackerApi::Client.new(token: '95dcacc6aebd8ed2a22fe4979685d0de')
  	@project  = client.project(1298888)
  end

  def update_state story_id, state
  	story = @project.story(110864818)
  	story.current_state = state
  	story.save
  end

  def Hello
  	puts "hi"
  end

  end
end

