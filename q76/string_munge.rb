
class String
  def munge!
    word_start = nil

    #is it a char
    # => start word or ignore
    #did we just end a word
    # => switch char with another in scope, including self
    #loop over, check for left over word
    # => switch char with another in scope, including self
    length.times do |pos|

      if self[pos] =~ /\w/
        word_start = pos + 1 unless word_start

      elsif word_start
        randomise!(word_start..(pos - 2))
        word_start = nil
      end
    end

    randomise!(word_start..(length - 2)) if word_start

    self
  end

  def munge
    self.dup.munge!
  end

  def randomise!(range)
    range.count.times do |offset|
      switch_with_pos = self[rand(range)]

      self[range.first + offset], self[switch_with_pos] = 
        self[switch_with_pos], self[range.first + offset]
    end
  end

end
