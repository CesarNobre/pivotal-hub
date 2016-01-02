require 'git'

module Pivotal_Hub
 
 class Git
 
  def is_git_branch
   Git.open(Dir.pwd).nil?
  end

  def get_current_branch
   if is_git_branch?
    Git.open(Dir.pwd)
   else
   	puts "ooops, current directory (#{Dir.pwd}) is not a git directory!"
  end

 end

end