require 'test/unit'
require_relative '../lib/Story'

class Story_test < Test::Unit::TestCase

 def test_Story_initialize
	story = Pivotal_Hub::Story.new
	assert story != nil
 end

end
