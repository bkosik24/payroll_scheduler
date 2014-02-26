require "date"
require_relative "../lib/date_parser"
class PayrollScheduler

  include DateParser
  attr_accessor :year, :date

  def initialize(year, date)
    @year = year
    @date = date
  end

  def find_dates_for_year
    # put all 12 months with given date in array
    dates = DateParser.grab_payday_for_year(@year, @date)
    dates.each_with_index do |date, index|
      dates[index] = DateParser.find_correct_date(date)
    end
    puts dates.join("\n")
  end

  def find_payouts_starting_on(start_date)
    parse_start_date = Date.parse(start_date)
    parse_start_date
  end

end
