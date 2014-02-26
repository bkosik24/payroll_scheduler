require "payroll_scheduler"

describe PayrollScheduler do
  before(:all) { @payroll_scheduler = PayrollScheduler.new(2013, 14) }
  context "#initialize" do
    it "must accept 2 arguments" do
      @payroll_scheduler.should_not be_nil
    end

    it "should return an ArgumentError if number of arguments is not 2" do
      expect {PayrollScheduler.new}.to raise_error(ArgumentError)
    end

  end

  context "#find_payouts_starting_on" do
    it "should accept a start date as a string" do
      p = @payroll_scheduler.find_payouts_starting_on("02/21/2013")
      p.should_not be_nil
    end
  end

end
