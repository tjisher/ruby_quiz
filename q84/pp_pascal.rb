
module Pascal
  class << self

    #Pascale Triangle
    #requires no of rows
    #
    #padding left and right, based on last row width
    #internal padding decreases as digits increase
    #starts at 1
    #each value is sum of two diagonally above
    #left/rightmost is always 1
    def triangle rows
      return "" unless rows.to_i > 0
      result = [[1]]

      (1..(rows - 1)).each do |row|
        result << [1]
        (1..row).each do |col|
          result[row] << result[row - 1][col - 1] + result[row - 1][col].to_i
        end
      end

      #spacing
      block_length = result[-1].max.to_s.length * 2
      longest_length = (block_length * result[-1].count) - 1 - (block_length - 2)

      result.collect! do |row|
        #center columns, into one string, remove outside padding, centre on longest
        row.collect { |col| col.to_s.center(block_length)}.join.strip.center(longest_length)
      end

      result.join("\n") + "\n"
    end

  end
end
