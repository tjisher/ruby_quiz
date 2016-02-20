##ToC
# Box Class

#Todo
# make sure most simple checks are in loop, as should be faster

##Box Class
# 
# key methods
# valid?, validate
class Box

	#return two characters make a open/close pair
	#unknown characters count as failure
	def self.matching_pair? a, b
		/\(\)|\[\]|{}/ === (a + b)
	end

	#boolean, wrapper for validate
	def self.valid? package
		validate( package) == nil
	end

	#checks a given package
	#returns error message or nil
	#
	def self.validate package
		failure_message = nil
		
		current_char_number = 1
		unclosed_opens = []
		unclosed_item = false
		open_before_item = false
		last_open = nil


		soft = "()"
		cardboard = "{}"
		wooden = "[]"
		item = "B"

		opens = "[{("
		closes = ")}]"

		#simple fails
		# empty
		# too short
		# first and last do not make pair
		# open and close count not even
		# 2 consecutive items
		# open/close with no item
		# without items must be even 
		if package.empty?
			failure_message = "No package to validate"
		elsif package.length < 3
			failure_message = "Package must be at least 3 characters"
		elsif !matching_pair?(package[0], package[-1])
			failure_message = "Outside of package does not match, maybe seperate packages"
		#elsif package.delete( "[]{}()B").length > package.length
		#	failure_message = "Illegal characters present"
		#elsif /BB+/ === package
		#	failure_message = "Items are not individually wrapped"
		elsif /\(\)|\[\]|{}/ === package #todo# refactor matching_pair?, else include the actual matched text
			failure_message = "Wrapping opens and closes without any content"
		#elsif !package.delete("B").length.even? 
		#	failure_message = "Incorrect number of opens and closes"
		end

		#fails
		# item with no open
		# close before open
		# close with no item
		# close not the last opened
		# illegal characters
		unless failure_message

			package.each_char do |char|

				#opens always allowed
				if opens.include?(char)
					unclosed_opens << char
					open_before_item = true
				#item
				elsif char == item
					#item with no open
					unless open_before_item 
						failure_message = "Item found with no open wrapping"
					end

					unclosed_item = true
					open_before_item = false
				#deal with a close
				elsif closes.include?(char)
					unless matching_pair?(unclosed_opens.last, char)
						#close not the last opened
						failure_message = "Item found with no open wrapping"
					end

					unclosed_item = false
					unclosed_opens.pop 
				else 
					failure_message = "Unknown character found:#{char}"
				end

				if failure_message
					failure_message += ", at position #{current_char_number}"
					break
				end
				current_char_number += 1
			end

		end

		failure_message += ". For package:#{package}" if failure_message
		puts "#{package}:#{failure_message}"
		failure_message
	end
end