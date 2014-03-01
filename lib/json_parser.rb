require "json"
require "date"
module JsonParser

  class Holidays
    attr_accessor :file

    def initialize(file)
      @file = File.open(file.strip)
    end

    def retrieve_dates
      begin
        json_object = JSON.parse(@file.read)
        holiday_array = []
        json_object.each do |key, holidays|
          holidays.each do |holiday|
            date = Date.strptime(holiday["date"], "%Y/%m/%d")
            holiday_array << date
          end
        end
        holiday_array
      rescue JSON::ParserError
        return "Not a valid JSON file"
      end
    end

  end

end
