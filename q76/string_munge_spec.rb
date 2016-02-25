require_relative 'string_munge.rb'

RSpec.describe String do
  describe "#munge" do
    it "takes an argument" do
      should respond_to(:munge).with(0).arguments
    end

    it "does not change the orginal" do
      src = "frank"
      src.munge

      expect( src ).to eq( "frank")
    end

    context "Single Word" do
      it "doesnt affect words less than 3 characters" do
        expect( "a".munge ).to eq("a")
        expect( "it".munge ).to eq("it")
      end

      it "doesnt change first and last characters" do
        src = "frank"
        word = src.munge

        expect( word[0] ).to eq("f")
        expect( word[-1] ).to eq("k")
      end

      it "randomly changes characters" do
        src = "pneumonoultramicroscopicsilicovolcanoconiosis" 
        word_one = src.munge
        word_two = src.munge
        word_three = src.munge
        all_equal = (word_one == word_two) and ( word_two == word_three)

        expect( all_equal ).to eq(false)
      end

      it "retinas all characters" do
        src = "frank" 
        word = src.munge

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
        word = src.munge

        expect( word[0] ).to eq(" ")
        expect( word[-1]  ).to eq(" ")
      end

      it "ignores non standard characters" do
        src = ":'#\n"
        word = src.munge

        expect( word[0] ).to eq(":")
        expect( word[1] ).to eq("'")
        expect( word[2] ).to eq("#")
        expect( word[-1] ).to eq("\n")
      end

      it "returns different results" do
        src = "a pneumonoultramic roscopicsilicovolcanoconiosis" 
        word_one = src.munge
        word_two = src.munge
        word_three = src.munge
        all_equal = (word_one == word_two) and ( word_two == word_three)

        expect( all_equal ).to eq(false)
      end
    end

    context "Multi word" do
      it "retinas all characters" do
        src = " frank  pete "
        response = src.munge

        src.each_char do |char|
          expect( response.count(char) ).to eq( src.count(char) )
        end
      end

      it "first and last characters are mainted and word positioning" do
        src = " frank  pete "
        response = src.munge

        expect( response[1] ).to eq( src[1] )
        expect( response[5] ).to eq( src[5] )
        expect( response[8] ).to eq( src[8] )
        expect( response[11] ).to eq( src[11] )
      end
    end

  end

  describe "#munge!" do
    it "takes an argument" do
      should respond_to(:munge!).with(0).arguments
    end

    context "Single Word" do
      it "doesnt affect words less than 3 characters" do
        expect( "a".munge! ).to eq("a")
        expect( "it".munge! ).to eq("it")
      end

      it "doesnt change first and last characters" do
        src = "frank"
        word = "frank".munge!

        expect( word[0] ).to eq("f")
        expect( word[-1] ).to eq("k")
      end

      it "randomly changes characters" do
        src = "pneumonoultramicroscopicsilicovolcanoconiosis" 
        word_one = "pneumonoultramicroscopicsilicovolcanoconiosis".munge!
        word_two = "pneumonoultramicroscopicsilicovolcanoconiosis".munge!
        word_three = "pneumonoultramicroscopicsilicovolcanoconiosis".munge!
        all_equal = (word_one == word_two) and ( word_two == word_three)

        expect( all_equal ).to eq(false)
      end

      it "retinas all characters" do
        src = "frank" 
        word = src.munge!

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
        word = src.munge!

        expect( word[0] ).to eq(" ")
        expect( word[-1]  ).to eq(" ")
      end

      it "ignores non standard characters" do
        src = ":'#\n"
        word = src.munge!

        expect( word[0] ).to eq(":")
        expect( word[1] ).to eq("'")
        expect( word[2] ).to eq("#")
        expect( word[-1] ).to eq("\n")
      end

      it "returns different results" do
        src = "a pneumonoultramic roscopicsilicovolcanoconiosis" 
        word_one = "a pneumonoultramic roscopicsilicovolcanoconiosis".munge!
        word_two = "a pneumonoultramic roscopicsilicovolcanoconiosis".munge!
        word_three = "a pneumonoultramic roscopicsilicovolcanoconiosis".munge!
        all_equal = (word_one == word_two) and ( word_two == word_three)

        expect( all_equal ).to eq(false)
      end
    end

    context "Multi word" do
      it "retinas all characters" do
        src = " frank  pete "
        response = " frank  pete ".munge!

        src.each_char do |char|
          expect( response.count(char) ).to eq( src.count(char) )
        end
      end

      it "first and last characters are mainted and word positioning" do
        src = " frank  pete "
        response = " frank  pete ".munge!

        expect( response[1] ).to eq( src[1] )
        expect( response[5] ).to eq( src[5] )
        expect( response[8] ).to eq( src[8] )
        expect( response[11] ).to eq( src[11] )
      end
    end
  end

end
