
module Pascale
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
      longest_length = block_length * result[-1].count - 1
      longest_length -= block_length - 2 #last row ends dont need padding

      result.each do |row|
        this_row = ""
        row.each do |col|
          this_row += col.to_s.center(block_length)
        end

        result_with_spacing += "#{this_row.strip.center(longest_length)}\n" 
      end

      result_with_spacing
    end

  end
end
