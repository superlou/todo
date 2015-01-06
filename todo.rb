require 'parslet'
require './todo_parser.rb'

begin
	parsed = TodoParser.new.parse(File.open("./task_test.txt", "rb").read)
rescue Parslet::ParseFailed => failure
	puts failure.cause.ascii_tree
end

puts parsed