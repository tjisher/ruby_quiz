##ToC
# Box Class

##Todo
# ? possible to be less britle if more wrapping types are added
# ? helper function to return prior/pre calculated 

##Box Class
# Validation of strings representing wrapping item(s)
# 
# key methods
# get_errors
class Box
	CONTAINER_CHARACTERS = ["()","{}","[]"]
	ITEM_CHARACTER = "B"

	#return if given string is a open/close pair
	#
	#optional parameters
	# non-default container character set
	def self.matching_pair?( pair, containers=CONTAINER_CHARACTERS)
		containers.include?( pair)
	end

	#boolean, wrapper for validate
	def self.valid?( package, containers=CONTAINER_CHARACTERS, 
			item_character=ITEM_CHARACTER)
		get_errors( package, containers, item_character) == nil
	end

	#checks if given string is a valid package
	#returns error message, nil for pass
	#
	#optional parameters
	# non-default container character set
	# non-default item character
	def self.get_errors( package, containers=CONTAINER_CHARACTERS, 
			item_character=ITEM_CHARACTER)

		failure_message = nil
		#make list of openers and closes
		opens = "" # ie [{(
		closes = "" # ie )}]
		containers.each do |pair| 
			opens += pair[0]
			closes += pair[1]
		end

		#simple fails
		# empty/too short
		# first and last do not make pair
		if !package.is_a?(String) || package.length < 3
			failure_message = "Package must be at least 3 characters"
		elsif !matching_pair?(package[0] + package[-1], containers)
			failure_message = "Outside of package does not match, maybe seperate packages"
		end

		#fails
		# item with no open
		# close before open
		# close with no item
		# close not the last opened
		# illegal characters
		unless failure_message
			current_char_position = 0
			unclosed_opens = []
			open_before_item = false
			last_open = nil

			package.each_char do |char|

				#opens always allowed
				if opens.include?(char)
					unclosed_opens << char
					open_before_item = true

				#deal with a close
				elsif closes.include?(char)
					if !matching_pair?( unclosed_opens.last + char, containers)
						#close not the last opened
						failure_message = "Closed wrapping that was not just opened"
					elsif matching_pair?( package[current_char_position - 1] + char, containers)
						#close with no item, ie ()
						failure_message = "Wrapping closed with no content"
					end
					unclosed_opens.pop 

				#item
				elsif char == item_character
					#item with no open
					unless open_before_item 
						failure_message = "Item found with no open wrapping"
					end
					open_before_item = false

				else 
					failure_message = "Unknown character found:#{char}"
				end

				if failure_message
					failure_message += ", at position #{current_char_position + 1}"
					break
				end
				current_char_position += 1
			end

		end

		failure_message += ". For package:#{package}" if failure_message
		failure_message
	end
end