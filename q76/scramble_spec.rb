require_relative 'scramble.rb'

RSpec.describe "#scramble" do
  it "takes an argument" do
    should respond_to(:triangle).with(1).arguments
  end

  context "Single Word" do
    it "doesnt affect words less than 3 characters" do
      expect( scramble("a") ).to eq("a")
      expect( scramble("it") ).to eq("it")
    end

    it "doesnt change first and last characters" do
      expect( scramble("frank").first ).to eq("f")
      expect( scramble("frank").last ).to eq("k")
    end

    it "retinas all characters" do
      src = "frank" 
      word = scramble(src)

      expect( word.length ).to eq(5)
      expect( word.count("f") ).to eq(1)
      expect( word.count("r") ).to eq(1)
      expect( word.count("a") ).to eq(1)
      expect( word.count("n") ).to eq(1)
      expect( word.count("k") ).to eq(1)
    end
  end

  context "With Spacing and other characters" do
    it "doesnt affect spacing" do
      src = " frank "
      word = scramble(src)

      expect( word.first ).to eq(" ")
      expect( word.last  ).to eq(" ")
    end

    it "ignores non standard characters" do
      src = ":'#\n"
      word = scramble(src)

      expect( word.first ).to eq(":")
      expect( word[1] ).to eq("'")
      expect( word[2] ).to eq("#")
      expect( word.last ).to eq("\n")
    end
  end

  context "Multi word" do
    it "retinas all characters" do
      src = " frank  pete "
      response = scramble(src)

      src.each_char do |char|
        expect( response.count(char) ).to eq( src.count(char) )
      end
    end

    it "first and last characters are mainted and word positioning" do
      src = " frank  pete "
      response = scramble(src)

      expect( response[1] ).to eq( src[1] )
      expect( response[5] ).to eq( src[5] )
      expect( response[8] ).to eq( src[8] )
      expect( response[11] ).to eq( src[11] )
    end
  end

end
