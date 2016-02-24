require_relative 'pp_pascal.rb'

RSpec.describe Pascale, "#triangle" do
  it { should respond_to(:triangle).with(1).arguments }

  it "should be respond as string" do
    expect(Pascale.triangle(1)).to be_kind_of(String)
  end

  it "0 value returns empty string" do
    actual = Pascale.triangle(0)
    expect(actual).to eq("")
  end

  it "correct for 2" do
    pp_two = <<-STR
    1    
   1 1   
STR
    expect(Pascale.triangle(2)).to eq(pp_two)
  end

  context "Orginal Specification" do
    it "correct for 5" do
      pp_five = <<-STR
    1    
   1 1   
  1 2 1  
 1 3 3 1 
1 4 6 4 1
STR
      expect(Pascale.triangle(5)).to eq(pp_five)
    end

    it "correct for 10" do
      pp_ten = <<-STR
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
STR
      expect(Pascale.triangle(10)).to eq(pp_ten)
    end
  end

end
