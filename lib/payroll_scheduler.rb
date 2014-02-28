#/usr/bin/ruby
require "date"
require_relative "../lib/date_parser"
class PayrollScheduler

  include DateParser
  attr_accessor :year, :date, :starting_date, :frequency

  VALID_FREQUENCIES = ["1 week", "2 week", "4 week", "13 week"]

  def initialize
  end

  def find_dates_for_year
    puts "What year?"
    @year = gets.chomp.to_i
    puts "Enter date"
    @date = gets.chomp.to_i
    # put all 12 months with given date in array
    dates = DateParser.grab_payday_for_year(@year, @date)
    output_dates(dates)
  end

  def find_payouts_starting_on_date
    puts "Enter Starting Date: (MM/DD/YYYY)"
    @starting_date = gets.chomp

    begin
      if @starting_date == ""
        puts "No valid starting date. Enter a new one:"
        @starting_date = gets.chomp
      else
        start_date = Date.strptime(@starting_date, "%m/%d/%Y")
        dates = DateParser.find_paydates_for_given_start_date(start_date)
        output_dates(dates)
      end
    rescue ArgumentError => e
      raise e
    end

  end

  def find_payouts_for_frequency
    puts "Enter Starting Date: (MM/DD/YYYY)"
    @starting_date = gets.chomp
    puts "Enter one of the following frequencies:\n#{VALID_FREQUENCIES.join(',')}:"
    @frequency = gets.chomp

    if @frequency == "" || !is_a_valid_frequency?
      return "Not a valid frequency. Please choose from one of the following: #{VALID_FREQUENCIES.join(', ')}"
    else
      dates = DateParser.find_dates_frequency(@frequency, @starting_date)
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


end
