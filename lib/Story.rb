require 'tracker_api'
require 'git'

module Pivotal_Hub
 class Story
  def initialize
    @git = Git.open(Dir.pwd)
  	@client = TrackerApi::Client.new(token: @git.config('pivotal.api-token'))
  	@project  = @client.project(@git.config('pivotal.project-id'))
    @label = @git.config('pivotal.sprint-label')
    @stories = @project.stories(with_label:@label)
    @chores = @stories.select{|story| story.story_type == "chore"}
    @features = @stories.select{|story| story.story_type == "feature"}
    @bugs = @stories.select{|story| story.story_type == "bug"}
    @dod_report = ""
  end

  def update_state story_id, state
  	story = @project.story(story_id)
  	story.current_state = state
    story.owner_ids = [@client.me.id]
  	story.save
    story
  end

  def get_current_branch
     @git.current_branch
  end
  
  def get_backlog_stories
    @project.stories(with_state: :unstarted, with_label:@label, limit: 10)
  end

  def create_and_switch_to_new_branch ticket_number
    branch_name = "#{ticket_number}_#{@client.me.name}"
    @git.branch(branch_name).checkout
  end

  def generate_dod
    stories = get_sprint_stories @label
    valid_stories = stories.select{|story| story.story_type != "release"}
    last_sprint = @label.split(//).last(1)[0].to_i - 1
    last_sprint_label = "#{@label.chop}#{last_sprint}"
    last_sprint_stories = get_sprint_stories last_sprint_label
    valid_stories_last_sprint = last_sprint_stories
                                .select{|story| story.story_type != "release" && story.current_state != "delivered" && story.current_state != "accepted" && story.current_state != "finished"}
    @dod_report << "**DoD - #{@label}** \n"
    @dod_report << "Pontos a serem entregues: #{sprint_total_points stories} \n"
    @dod_report << "Tickets a serem entregues: #{valid_stories.count} \n"
    @dod_report << "Pontos atrasados que serao entregues: #{stories_last_sprint} \n"
    @dod_report << "Tickets atrasados que serao entregues: #{valid_stories_last_sprint.count} \n"
    @dod_report << "\n"

    append_features
    append_bugs
    append_chores

    f = File.new("dod.txt","w")
    f.write(@dod_report)
    f.close()
  end

  def sprint_total_points stories
    valid_stories = stories.select{|story| story.story_type != "release"}
    valid_stories.inject(0){|sum, story| sum += story.estimate}
  end

  def get_sprint_stories label
    @project.stories(with_label:label)
  end
  
  def sprint_total_stories
    @project.stories(with_label:@label)
  end

  def stories_last_sprint
    last_sprint = @label.split(//).last(1)[0].to_i - 1
    last_sprint_label = "#{@label.chop}#{last_sprint}"
    stories = get_sprint_stories last_sprint_label
    valid_stories = stories.select{|story| story.story_type != "release" && story.current_state != "delivered" && story.current_state != "accepted" && story.current_state != "finished"}
    valid_stories.inject(0){|sum, story| sum += story.estimate}
  end

  def append_features
    @dod_report << "**Features** \n"
    @features.each do |story|
      @dod_report << "> ##{story.id} - #{story.name} - #{story.estimate} pontos \n"
    end
    @dod_report << "\n"
  end

  def append_bugs
    @dod_report << "**Bugs** \n"
    @bugs.each do |story|
      @dod_report << "> ##{story.id} - #{story.name} - #{story.estimate} pontos \n"
    end
    @dod_report << "\n"
  end

  def append_chores
    @dod_report << "**Chores** \n"
    @chores.each do |story|
      @dod_report << "> ##{story.id} - #{story.name} - #{story.estimate} pontos \n"
    end
    @dod_report << "\n"
  end

end
end

