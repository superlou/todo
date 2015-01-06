require 'parslet'

# check http://viget.com/extend/write-you-a-parser-for-fun-and-win

class TodoParser < Parslet::Parser
	rule(:space) { match('\s').repeat(1) }
	rule(:space?) { space.maybe }
  rule(:newline) { match['\\n'] }
  rule(:newline?) { newline.maybe }

  rule(:left_bracket) { match '\\[' }
  rule(:right_bracket) { match '\\]' }
  rule(:status_symbol) { match['xX '].maybe }

	rule(:open_box) { left_bracket >> status_symbol.as(:status) >> right_bracket }

  rule(:name) { (match['a-zA-Z0-9 ']).repeat}

  rule(:indent) { match('\s').repeat }
  rule(:date) { match['0-9'].repeat(4) >> match('-') >> match['0-9'].repeat(2) >> match('-') >> match['0-9'].repeat(2)}
  rule(:time) { match['0-9'].repeat(2) >> match(':') >> match['0-9'].repeat(2) }
  rule(:update) { indent >> date >> time }
  rule(:update?) { update.maybe }

	rule(:task) { open_box >> space? >> name.as(:name) >> (newline >> update).maybe}
	rule(:tasks) { (task >> newline?).repeat }
	root(:tasks)
end