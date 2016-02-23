require_relative 'pp_pascal.rb'

RSpec.describe Pascale, "#triangle" do
	it { should respond_to(:triangle).with(1).arguments }

	it "triangle with 0 is empty string" do
		actual = Pascale.triangle(0)
		expect(actual).to be("")
	end
end
