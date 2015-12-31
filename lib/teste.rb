dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.join(dir, 'Story')

class Teste
	def initialize
		
	end

	def arroz
		arroz = Story.new
		options = {
			'current_state' => 'started'
		}
		arroz.update(110864818,options)
	end
end

feijoada = Teste.new

feijoada.arroz