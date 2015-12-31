require 'httparty'
class Story
 include HTTParty
 
 def initialize
 	@base_uri = "www.pivotaltracker.com/"
 	@project_id = '1187076'
 	@project_uri = "#{base_uri}#{project_id}"
 	@token = "95dcacc6aebd8ed2a22fe4979685d0de"
 	@header = {
 		headers => { 
 			'X-TrackerToken' => "#{@token}",
 			'Content-Type' => 'application/json', 
 			'Accept' => 'application/json'}
 	}

 end

 def update story_id, options
 	options.merge(@header)
 	self.class.put("#{@project_uri}/stories/#{story_id}",options)
 end

end