require "json_parser"

describe JsonParser::Holidays do
  let(:json_parser) { JsonParser::Holidays.new("data/holidays.json") }
  let(:bad_json_data) { JsonParser::Holidays.new("data/bad_json.json") }

  context "#initialize" do
    it "should open a file from the path a user provided" do
      File.exist?(json_parser.file).should be_true
    end
  end

  context "#retrieve_dates" do

    it "should return a parse error if it's not a valid JSON file" do
      expect{bad_json_data.retrieve_dates}.to raise_error(RuntimeError)
    end

    it "should return an array of dates" do
      json_parser.retrieve_dates.is_a?(Array)
    end

  end

end
