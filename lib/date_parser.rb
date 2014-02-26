# require "date"
module DateParser

  class << self

    def find_correct_date(date)
      check_date_is_weekend(date) ?
      find_preceding_friday(date) :
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

    def find_preceding_friday(date)
      case date.wday
      when 0
        date = (date - 2)
      when 6
        date = (date - 1)
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

  end
end
