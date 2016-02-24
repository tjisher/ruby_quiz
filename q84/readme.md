
http://rubyquiz.com/quiz84.html

###Orginal Specification
pp Pascal (#84)
by Dirk Meijer

I recently showed a friend what an amazing language Ruby was, by quickly programming up a script to calculate Fibonacci's Sequence, and his first response was: "Can you do Pascal's Triangle?" So I did, which proved harder than expected.

For those not familiar with Pascal's Triangle, it is very similar to Fibonacci's Sequence. It's a pyramid of numbers. The outside of the pyramid is all ones, the other numbers are the sum of the two numbers above, like this:

    1    
   1 1   
  1 2 1  
 1 3 3 1 
1 4 6 4 1

The input and output should be as follows:

$ ruby pp_pascal.rb 10
                           1                           
                        1     1                        
                     1     2     1                     
                  1     3     3     1                  
               1     4     6     4     1               
            1     5    10    10     5     1            
         1     6    15    20    15     6     1         
      1     7    21    35    35    21     7     1      
   1     8    28    56    70    56    28     8     1   
1     9    36    84    126   126   84    36     9     1

A number should be given as command-line argument. This is the amount of rows the triangle has. For the output, there should be spacing between the numbers based on the size of the numbers with the most digits, so it will look like a proper triangle.

Good luck!

###Extended Spec

stage_1

