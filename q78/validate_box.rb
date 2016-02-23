##ToC
# Box Module

##Todo
# ? possible to be less britle if more wrapping types are added
# ? helper function to return prior/pre calculated 
# failure state for unknown errors?

##Box Class
# Validation of strings representing wrapping item(s)
# 
#
# key public methods
# valid?, validate
#
# key private methods
# get_errors
class Box
	CONTAINER_CHARACTERS = ["()","{}","[]"]
	ITEM_CHARACTER = "B"
	ERROR_MESSAGE_TYPES = {
		too_short: "Package must be at least 3 characters",
		outside_mismatch: "Outside of package does not match, maybe seperate packages",
		close_mismatch: "Closed wrapping that was not just opened",
		close_no_item: "Wrapping closed with no content",
		item_no_open: "Item found with no open wrapping",
		unknown_character: "Unknown character found:"
	}

	#boolean, wrapper for validate
	#
	#optional parameters
	# non-default container character set
	# non-default item character
	def self.valid?( package, containers=CONTAINER_CHARACTERS, 
			item_character=ITEM_CHARACTER)
		get_errors( package, containers, item_character) == nil
	end

	#checks if given string is a valid package
	#returns nil for pass, error message for failure
	#
	#optional parameters
	# non-default container character set
	# non-default item character
	def self.validate( package, containers=CONTAINER_CHARACTERS, 
			item_character=ITEM_CHARACTER)
		error_to_string( get_errors( package, containers, item_character) )
	end

	#returns valid version of given package
	#if already valid makes no changes
	#WARNING: significant and substative changes are likely
	def self.suggest( package, error=:nil, containers=CONTAINER_CHARACTERS, 
			item_character=ITEM_CHARACTER)
		error = get_errors( package, containers, item_character) unless error
		return package unless error

		#prep
		suggestion =  nil
		open_close_chars = get_open_closes( containers)

		#signals
		item_count = package.count( item_character)


		#attempt
		if error[:type] == :too_short
		#empty, short
			if !package.is_a?(String) || package.empty?
				suggestion = "(B)"
			elsif item_count = 1
				#something appropiate to wrap
			end	
		elsif condition
		#typos
		#removals
		# illegal, no items
		#first/last
		#close mismatch
		#close with no open
		end
	end

	def frank( package, containers=CONTAINER_CHARACTERS, 
			item_character=ITEM_CHARACTER)
		open_close_chars = get_open_closes( containers)

		#{(B)}
		#{
		# (B) == nil
		#}

		#{(B)
		#{
		# (B) == nil

		current_char_position = 0
		working = {}
		layer = 0
		package.each_char do |char|
			this_layer = working[layer]
			parent_layer = working[layer - 1]

			if open_close_chars[:opens].include?(char)
				
			elsif open_close_chars[:closes].include?(char)

			elsif char == item_character

			end
			
			current_char_position += 1
		end

	end

	private

	#get user friendly version of given error object
	#nil if no error given
	def self.error_to_string( error, messages=ERROR_MESSAGE_TYPES )
		return error unless error

		message = messages[ error[:type]]
		message += ", at position #{error[:position] + 1}" if error[:position]
		message += ", character:#{error[:char]}" if error[:char]
		message += ". For package:#{error[:package]}." if error[:package]
	end 

	#return if given string is a open/close pair
	#
	#optional parameters
	# non-default container character set
	def self.matching_pair?( pair, containers=CONTAINER_CHARACTERS)
		containers.include?( pair)
		#todo# remove this and replace in situ
	end


	#get hash of all open characters and all close characters from container
	def self.get_open_closes( containers=CONTAINER_CHARACTERS)
		opens = "" # ie [{(
		closes = "" # ie )}]
		containers.each do |pair| 
			opens += pair[0]
			closes += pair[1]
		end

		{ opens: opens, closes: closes }
	end


	def self.close_for_open( open, containers=CONTAINER_CHARACTERS)
		open_close_chars = get_open_closes( containers)
		open_close_chars[:closes][ open_close_chars[:opens].index( open) ]
	end

	def self.open_for_close( close, containers=CONTAINER_CHARACTERS)
		open_close_chars = get_open_closes( containers)
		open_close_chars[:opens][ open_close_chars[:closes].index( close) ]
	end

	#checks if given string is a valid package
	#returns error message, nil for pass
	#
	#optional parameters
	# non-default container character set
	# non-default item character
	def self.get_errors( package, containers=CONTAINER_CHARACTERS, 
			item_character=ITEM_CHARACTER)

		error = nil
		#make list of openers and closes
		open_close_chars = get_open_closes( containers)

		#simple fails
		# empty/too short
		# first and last do not make pair
		if !package.is_a?(String) || package.length < 3
			error = {type: :too_short}
		elsif !matching_pair?(package[0] + package[-1], containers)
			error = {type: :outside_mismatch}
		end

		#fails
		# item with no open
		# close before open
		# close with no item
		# close not the last opened
		# illegal characters
		unless error
			current_char_position = 0
			unclosed_opens = []
			open_before_item = false
			last_open = nil

			package.each_char do |char|

				#opens always allowed
				if open_close_chars[:opens].include?(char)
					unclosed_opens << char
					open_before_item = true

				#deal with a close
				elsif open_close_chars[:closes].include?(char)
					if !matching_pair?( unclosed_opens.last + char, containers)
						#close not the last opened
						error = {type: :close_mismatch, last_unclosed: unclosed_opens.last}
					elsif matching_pair?( package[current_char_position - 1] + char, containers)
						#close with no item, ie ()
						error = {type: :close_no_item}
					end
					unclosed_opens.pop 

				#item
				elsif char == item_character
					#item with no open
					unless open_before_item 
						error = {type: :item_no_open}
					end
					open_before_item = false

				else 
					error = {type: :unknown_character}
				end

				error.merge!( { position: current_char_position, last_char: char }) if error
				break if error
				current_char_position += 1
			end

		end

		error[:package] = package if error
		error
	end
end