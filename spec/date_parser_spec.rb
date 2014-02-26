require "date_parser"

describe DateParser do

  before(:all) do
    @valid_date = 14
    @year = 2013
  end

  context "#grab_payday_for_year" do
    it "must accept 2 arguments" do
      expect {DateParser.grab_payday_for_year}.to raise_error(ArgumentError)
    end

    it "should return the value of an array" do
      dates = DateParser.grab_payday_for_year(@year, @valid_date)
      dates.is_a?(Array)
    end
  end

  context "#valid_weekday" do

    it "should return a date object" do
      date = DateParser.valid_weekday(@year, 2, @valid_date)
      date.is_a?(Date)
    end

    it "should return the date passed in if valid date" do
      date = DateParser.valid_weekday(@year, 2, @valid_date)
      date.should == Date.new(@year, 2, @valid_date)
    end

  end

end
