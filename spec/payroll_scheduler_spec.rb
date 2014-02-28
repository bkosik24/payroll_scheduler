require "payroll_scheduler"

describe PayrollScheduler do
  before(:all){ @payroll_scheduler = PayrollScheduler.new }

  context "#find_dates_for_year" do
    before(:each) { @payroll_scheduler.stub(:gets).and_return("2013\n", "15\n") }

    it "must accept user inputs" do
      @payroll_scheduler.find_dates_for_year.is_a?(Array)
    end

    it "must return an array of size 12" do
      @payroll_scheduler.find_dates_for_year.size.should == 12
    end

  end

  context "#find_payouts_for_frequency" do
    before(:each) do
      stub_const("VALID_FREQUENCIES", ["1 week", "2 weeks", "4 weeks", "13 weeks"])
      @payroll_scheduler.stub(:gets).and_return("02/01/2013\n", "2 weeks\n")
    end

    it "must accept user inputs and return the dates in an array" do
      @payroll_scheduler.find_payouts_for_frequency.is_a?(Array)
    end

    it "must return a message if a user enters in an incorrect frequency" do
      @payroll_scheduler.stub(:gets).and_return("02/01/2013\n", "2 week\n")
      @payroll_scheduler.find_payouts_for_frequency.should == "Not a valid frequency. Please choose from one of the following: #{VALID_FREQUENCIES.join(', ')}"
    end

    # test method with different start dates and frequencies
    it "must return an array of size 24 with given start date and frequency provided" do
      @payroll_scheduler.find_payouts_for_frequency.size.should == 24
    end

    it "must return an array of size 9 with given start date and frequency provided" do
      @payroll_scheduler.stub(:gets).and_return("05/13/2013\n", "4 weeks\n")
      @payroll_scheduler.find_payouts_for_frequency.size.should == 9
    end

    it "must return an array of size 4 with given start date and frequency provided" do
      @payroll_scheduler.stub(:gets).and_return("01/13/2013\n", "13 weeks\n")
      @payroll_scheduler.find_payouts_for_frequency.size.should == 4
    end

  end

end
