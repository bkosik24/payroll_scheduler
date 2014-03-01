require "date_parser"
require "json_parser"
describe DateParser do

  before(:all) { @valid_date = 14; @year = 2013 }
  let(:weekday) { Date.new(2014, 3, 20) }
  let(:saturday_date) { Date.new(2014, 10, 25)}
  let(:sunday_date) { Date.new(2014, 8, 10)}
  let(:frequency) { "2 week" }
  let(:public_holidays) { @public_holidays = JsonParser::Holidays.new("data/holidays.json").retrieve_dates }

  context "#grab_payday_for_year" do
    it "must accept 2 arguments" do
      expect {DateParser.grab_payday_for_year}.to raise_error(ArgumentError)
    end

    it "should return the value of an array" do
      dates = DateParser.grab_payday_for_year(@year, @valid_date, public_holidays)
      dates.is_a?(Array)
    end
  end

  context "#valid_weekday" do
    let(:date){ DateParser.valid_weekday(@year, 2, @valid_date, public_holidays) }
    it "should return a date object" do
      date.is_a?(Date)
    end

    it "should return the date passed in if valid date" do
      date.should == Date.new(@year, 2, @valid_date)
    end
  end

  context "#check_date_is_weekend" do
    it "should return false for a date of 2/20/2014" do
      date = Date.new(2014, 02, 20)
      DateParser.check_date_is_weekend(date).should be_false
    end

    it "should return true for a date of 10/25/2014" do
      date = Date.new(2014, 10, 25)
      DateParser.check_date_is_weekend(date, ).should be_true
    end
  end

  context "#format_date" do
    it "should return a formatted string of a date object" do
      date = Date.new(2014, 10, 25)
      DateParser.format_date(date).should == "Saturday, October 25, 2014"
    end
  end

  context "#find_next_valid_date" do
    it "should return a date of Friday, October 24, 2014 given a Saturday date entered" do
      dp = DateParser.find_next_valid_date(saturday_date)
      dp.should == "Friday, October 24, 2014"
    end

    it "should return a date of Friday, August 8, 2014 given a Sunday date in the middle of the month entered" do
      DateParser.find_next_valid_date(sunday_date).should == "Friday, August 8, 2014"
    end

    it "should return a date of Monday, June 2, 2014 given a Sunday date in the beginning of the month entered" do
      date = Date.new(2014, 6, 1)
      DateParser.find_next_valid_date(date).should == "Monday, June 2, 2014"
    end

    it "should return a date of Monday, March 3, 2014 given a Saturday date in the beginning of the month entered" do
      date = Date.new(2014, 3, 3)
      DateParser.find_next_valid_date(date).should == "Monday, March 3, 2014"
    end

    it "should return a date of Monday, February 3, 2014 given a Sunday date in the beginning of the month entered" do
      date = Date.new(2014, 2, 3)
      DateParser.find_next_valid_date(date).should == "Monday, February 3, 2014"
    end
  end

  context "#find_dates_for_given_frequency" do
    it "should return an array based on start date AND frequency" do
      dates = DateParser.find_dates_for_given_frequency(weekday, frequency, public_holidays)
      dates.is_a?(Array)
    end

    it "should return an array with size 21 given the date is 3/20/2014 and a frequency of 2 weeks" do
      dates = DateParser.find_dates_for_given_frequency(weekday, frequency, public_holidays)
      dates.size.should == 21
    end

    it "should return an array with size 11 given the date is 3/20/2014 and a frequency of 4 weeks" do
      dates = DateParser.find_dates_for_given_frequency(weekday, "4 week", public_holidays)
      dates.size.should == 11
    end
  end

  context "#find_paydates_for_given_start_date" do
    it "should return an array with a given start date with no frequency" do
      dates = DateParser.find_paydates_for_given_start_date(weekday, public_holidays)
      dates.is_a?(Array)
    end

    it "should return an array with size 10 given the date is 3/20/2014 and a frequency of 4 weeks" do
      dates = DateParser.find_paydates_for_given_start_date(weekday, public_holidays)
      dates.size.should == 10
    end
  end

end
