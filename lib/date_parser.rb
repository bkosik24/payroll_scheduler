# require "date"
module DateParser

  class << self

    def find_correct_date(date)
      check_date_is_weekend(date) ?
      find_next_valid_date(date) :
      format_date(date)
    end

    def grab_payday_for_year(year, date)
      date_array = []
      (1..12).each do |month|
        date_array << valid_weekday(year, month, date)
      end
      date_array
    end

    def check_date_is_weekend(date)
      return true if (date.wday == 0 || date.wday == 6)
    end

    def format_date(date)
      date = date.strftime("%A, %B %-d, %Y")
    end

    def find_next_valid_date(date)
      # We ultimately want the preceding Friday but if that preceding Friday is
      # in the previous month, we want to find the next valid date after the
      # given date
      case date.wday
      when 0
        date = ((date - 2).month != date.month) ? (date + 1) : (date - 2)
      when 6
        date = ((date - 1).month != date.month) ? (date + 2) : (date - 1)
      end
      format_date(date)
    end

    def valid_weekday(year, month, date)
      if !Date.valid_date?(year, month, date)
        last_day_of_month = Date.civil(year, month, -1)
        date_object = Date.parse(find_correct_date(last_day_of_month))
      else
        date_object = Date.new(year, month, date)
      end
    end

    def find_dates_for_date_and_frequency(frequency, start_date)
      start_date = start_date == "" ? "01/01/2014" : start_date
      start_date = Date.strptime(start_date, "%m/%d/%Y")
      # if no frequency, then we will assume it's monthly
      if frequency == ""
        find_paydates_for_given_start_date(start_date)
      else
        find_dates_for_given_frequency(start_date, frequency)
      end
    end

    def find_dates_for_given_frequency(start_date, frequency)
      date_array = [start_date]
      original_start_date = start_date
      num = extract_number_in_frequency_phrase(frequency)
      begin
        next_date = (start_date + num)
        date_array << next_date
        start_date = next_date
      end while (original_start_date.year == next_date.year)
      date_array = date_array.reject{|d| d if d.year != original_start_date.year}
    end

    def find_paydates_for_given_start_date(start_date)
      date_array = [start_date]
      original_start_date = start_date
      begin
        next_month_date = (start_date >> 1)
        date_array << next_month_date
        start_date = next_month_date
      end while (original_start_date.year == start_date.year)
      date_array = date_array.reject{|d| d if d.year != original_start_date.year}
    end

    private

    def extract_number_in_frequency_phrase(frequency)
      number_of_weeks = frequency.split(" ")[0].to_i
      (7 * number_of_weeks)
    end

  end
end
