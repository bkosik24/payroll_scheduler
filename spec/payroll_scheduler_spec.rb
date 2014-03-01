require "payroll_scheduler"

describe PayrollScheduler do
  before(:all){ @payroll_scheduler = PayrollScheduler.new }

  context "#find_dates_for_year" do
    before(:each) { @payroll_scheduler.stub(:gets).and_return("2013\n", "15\n") }

    it "must accept user inputs" do
      @payroll_scheduler.find_dates_for_year.is_a?(Array)
    end

  end

  context "#find_payroll_dates_for_start_and_frequency" do
    before(:each) do
      stub_const("VALID_FREQUENCIES", ["1 week", "2 week", "4 week", "13 week"])
      @payroll_scheduler.stub(:gets).and_return("02/01/2013\n", "2 week\n")
    end

    it "must return a message if a user enters in an incorrect frequency" do
      @payroll_scheduler.stub(:gets).and_return("02/01/2013\n", "2 weeks\n")
      @payroll_scheduler.find_payroll_dates_for_start_and_frequency.should == "Not a valid frequency. Please choose from one of the following: #{VALID_FREQUENCIES.join(', ')}"
    end

  end

end
