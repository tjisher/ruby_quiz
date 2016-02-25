def scramble text
  result = ""
  word = ""

  text.each_char do |char|
    if char =~ /\w/
      word += char
    elsif !word.empty?
      #word just ended
      word = scramble_word(word)
      result += word + char
      print word
      print char

      word = ""
    else
      #no word and ignorable char
      result += char
      print char
    end
  end

  #check if eneded with word
  unless word.empty?
    word = scramble_word(word)
    result += word
    print word
  end

  result
end


def scramble_word word
  return word if word.length < 4
  word[0] + word.chars[1..-2].sort{ rand <=> rand }.join + word[-1]
end
