#/usr/bin/ruby
require "date"
require_relative "../lib/date_parser"
class PayrollScheduler

  include DateParser
  attr_accessor :year, :date, :starting_date, :frequency

  VALID_FREQUENCIES = ["1 week", "2 weeks", "4 weeks", "13 weeks"]

  def initialize
  end

  def find_dates_for_year
    puts "What year?"
    @year = gets.chomp.to_i
    puts "Enter date"
    @date = gets.chomp.to_i
    # put all 12 months with given date in array
    dates = DateParser.grab_payday_for_year(@year, @date)
    dates.each_with_index do |date, index|
      dates[index] = DateParser.find_correct_date(date)
    end
    dates
  end

  # TODO - implement method
  # def find_payouts_starting_on_date
  #   if @starting_date == ""
  #     puts "No valid starting date. Enter a new one:"
  #     @starting_date = gets.chomp
  #   else
  #     parse_start_date = Date.strptime(@starting_date, "%m/%d/%Y")
  #   end

  # end

  def find_payouts_for_frequency
    puts "Enter Starting Date: (MM/DD/YYYY)"
    @starting_date = gets.chomp
    puts "Enter one of the following frequencies:\n#{VALID_FREQUENCIES.join(',')}:"
    @frequency = gets.chomp

    if @frequency == "" || !is_a_valid_frequency?
      return "Not a valid frequency. Please choose from one of the following: #{VALID_FREQUENCIES.join(', ')}"
    else
      dates = DateParser.find_dates_frequency(@frequency, @starting_date)
      dates.each_with_index do |date, index|
        dates[index] = DateParser.find_correct_date(date)
      end
      dates
    end
  end

  def is_a_valid_frequency?
    VALID_FREQUENCIES.include?(@frequency) ? true : false
  end

end
