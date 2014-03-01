require "date_parser"
require "json_parser"
class PayrollScheduler

  include DateParser
  include JsonParser

  attr_accessor :output, :public_holidays

  VALID_FREQUENCIES = ["1 week", "2 week", "4 week", "13 week"]

  def choose_payroll_output
    puts "Choose one of the below options:\nOption 1 to enter a year & date\nOption 2 to enter a start date & frequency"
    @output = gets.chomp
  end

  def find_dates_for_year
    ask_for_year_and_month_date
    # put all 12 months with given date in array
    dates = DateParser.grab_payday_for_year(@year, @date, @public_holidays)
    output_dates(dates)
  end

  def find_payroll_dates_for_start_and_frequency
    ask_for_start_date_and_frequency
    if @frequency != "" && !is_a_valid_frequency?
      return "Not a valid frequency. Please choose from one of the following: #{VALID_FREQUENCIES.join(', ')}"
    else
      dates = DateParser.find_dates_for_date_and_frequency(@frequency, @starting_date, @public_holidays)
      output_dates(dates)
    end
  end

  def is_a_valid_frequency?
    VALID_FREQUENCIES.include?(@frequency) ? true : false
  end

private

  def output_dates(dates)
    dates.each_with_index do |date, index|
      dates[index] = DateParser.find_correct_date(date)
    end
    puts dates
  end

  def ask_for_year_and_month_date
    puts "Enter a year:"
    @year = gets.chomp.to_i
    puts "Enter day of the month:"
    @date = gets.chomp.to_i
    ask_for_json_holiday_file
  end

  def ask_for_start_date_and_frequency
    puts "Enter Starting Date: (MM/DD/YYYY):"
    @starting_date = gets.chomp
    puts "Enter one of the following frequencies:\n#{VALID_FREQUENCIES.join(', ')}:"
    @frequency = gets.chomp
    ask_for_json_holiday_file
  end

  def ask_for_json_holiday_file
    puts "Upload public holiday file (JSON only):"
    @public_holidays = JsonParser::Holidays.new(gets.chomp).retrieve_dates rescue nil
  end

end
