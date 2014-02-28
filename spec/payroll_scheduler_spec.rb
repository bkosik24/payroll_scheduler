require "payroll_scheduler"

describe PayrollScheduler do
  before(:all){ @payroll_scheduler = PayrollScheduler.new }

  context "#find_dates_for_year" do
    before(:each) { @payroll_scheduler.stub(:gets).and_return("2013\n", "15\n") }

    it "must accept user inputs" do
      @payroll_scheduler.find_dates_for_year.is_a?(Array)
    end

  end

  context "find_payouts_starting_on_date" do

    it "will return an ArgumentError if an invalid date is supplied" do
      @payroll_scheduler.stub(:gets).and_return("02/99/2013\n")
      expect {@payroll_scheduler.find_payouts_starting_on_date}.to raise_error(ArgumentError)
    end

  end


  context "#find_payouts_for_frequency" do
    before(:each) do
      stub_const("VALID_FREQUENCIES", ["1 week", "2 week", "4 week", "13 week"])
      @payroll_scheduler.stub(:gets).and_return("02/01/2013\n", "2 week\n")
    end

    it "must accept user inputs and return the dates in an array" do
      @payroll_scheduler.find_payouts_for_frequency.is_a?(Array)
    end

    it "must return a message if a user enters in an incorrect frequency" do
      @payroll_scheduler.stub(:gets).and_return("02/01/2013\n", "2 weeks\n")
      @payroll_scheduler.find_payouts_for_frequency.should == "Not a valid frequency. Please choose from one of the following: #{VALID_FREQUENCIES.join(', ')}"
    end

  end

end
