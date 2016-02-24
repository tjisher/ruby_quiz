
module Pascale
  class << self

    def triangle rows
      result = []
      result_with_spacing = ""

      #padding left and right, based on last row width
      #internal padding decreases as digits increase
      #starts at 1
      #each value is sum of two diagonly above
      #left/rightmost is always 1

      rows.times do |row|
        result << []

        (row + 1).times do |col|

          if col == 0 || col == row
            result[row] << 1
          else
            result[row] << (result[row - 1][col - 1] + result[row - 1][col])
          end

          #puts "t:#{rows} r:#{row}, c:#{col}, #{result.inspect}"

        end
      end

      result.each do |row|
        row.count.times do |col|

          case col
          when 0
            #prefil
            result_with_spacing += "#{row[col]} "
          when (row.count - 1)
            #postfil
            result_with_spacing += "#{row[col]}"
          else
            #interfil
            result_with_spacing += "#{row[col]} "
          end
        end

        result_with_spacing += "\n"
      end

      result_with_spacing
    end

  end
end
