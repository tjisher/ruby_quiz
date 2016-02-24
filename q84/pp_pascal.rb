
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
      result = []
      result_with_spacing = ""
      return "" unless rows.to_i > 0


      rows.times do |row|
        result << []

        (row + 1).times do |col|

          if col == 0 || col == row
            result[row] << 1
          else
            result[row] << (result[row - 1][col - 1] + result[row - 1][col])
          end
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
