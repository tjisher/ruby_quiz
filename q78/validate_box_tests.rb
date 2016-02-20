##TOC
#methods and empty payload
#basic types
#nested types
#orignal specification

#TOD#
# all iterations
# validate matches valid?
# ? change must_output to check exit code

require_relative 'validate_box.rb'
require 'minitest/spec'
require 'minitest/autorun'

describe Box do
	#methods and empty payload
	it "answers to valid?" do
		Box.must_respond_to(:valid?, "")
	end
	it "answers to validate" do
		Box.must_respond_to(:validate, "")
	end

	it "fails empty strings" do
		Box.valid?("").must_be_same_as(false)
	end

	#basic types
	it "passes soft wraping" do
		Box.valid?("(B)").must_be_same_as(true)
	end

	it "passes cardboard box" do
		Box.valid?("[B]").must_be_same_as(true)
	end

	it "passes wooden box" do
		Box.valid?("{B}").must_be_same_as(true)
	end

	it "fails unknown boxing" do
		Box.valid?("|B|").must_be_same_as(false)
	end

	it "fails unknown boxed item" do
		Box.valid?("{Z}").must_be_same_as(false)
	end

	it "fails when nothing wrapped" do
		Box.valid?("{}").must_be_same_as(false)
	end

	it "fails when there is no wrapping" do
		Box.valid?("B").must_be_same_as(false)
	end

	it "fails when items are not individualy wrapped" do
		Box.valid?("(BB)").must_be_same_as(false)
	end

	it "fails when warpping is started but not closed" do
		Box.valid?("(B").must_be_same_as(false)
		#todo# all iterations)
	end

	it "fails when warpping is not started" do
		Box.valid?("B)").must_be_same_as(false)
		#todo# all iterations
	end

	#nested types
	it "passes item inside two wrappings" do
		Box.valid?("{(B)}").must_be_same_as(true)
		#todo# all iterations
	end

	it "passes item inside three wrappings" do
		Box.valid?("[{(B)}]").must_be_same_as(true)
	end

	it "passes two wrapped items" do
		Box.valid?("{(B)(B)}").must_be_same_as(true)
		#todo# all iterations
	end

	it "passes multiple wrapped items" do
		Box.valid?("[{(B)}{(B)(B)}]").must_be_same_as(true)
		#todo# all iterations
	end

	it "fails when nested wrapping is started but not closed" do
		Box.valid?("{(B)").must_be_same_as(false)
		#todo# all iterations
	end

	it "fails when nested wrapping is closed but not started" do
		Box.valid?("(B)}").must_be_same_as(false)
		#todo# all iterations
	end

	it "fails when nested wrapping is closed too soon" do
		Box.valid?("{(B})").must_be_same_as(false)
		#todo# all iterations
	end

	#orignal specification
	# => against valid?
	it "passes orginal specification example 1: [{(B)}{(B)(B)}]" do
		Box.valid?("[{(B)}{(B)(B)}]").must_be_same_as(true)
		#todo# remove this repeated test ?
	end

	it "fails for orignal specification example 2: [{(B}{(B)(B)}]" do
		Box.valid?("[{(B}{(B)(B)}]").must_be_same_as(false)
	end

	it "fails for orignal specification example 3: {(B)}{(B)(B)}]" do
		Box.valid?("{(B)}{(B)(B)}]").must_be_same_as(false)
	end

	# => against ouput
	it "returns 0 for orginal specification example 1: [{(B)}{(B)(B)}]" do
		skip
		Box.validate("[{(B)}{(B)(B)}]").must_output(0)
	end

	it "returns 1 for orignal specification example 2: [{(B}{(B)(B)}]" do
		skip
		Box.validate("[{(B}{(B)(B)}]").must_output(1)
	end

	it "returns 1 for orignal specification example 3: {(B)}{(B)(B)}]" do
		skip
		Box.validate("{(B)}{(B)(B)}]").must_output(1)
	end

end
