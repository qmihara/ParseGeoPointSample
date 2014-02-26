require 'dotenv'
require 'parse-ruby-client'
require 'smarter_csv'

if ARGV.length == 0
  puts 'usage:'
  puts '      ruby import.rb {CSV_FILE_PATH}'
  exit 1
end

csv_file_path = ARGV[0]

Dotenv.load

Parse.init application_id: ENV['PARSE_APPLICATION_ID'], api_key: ENV['PARSE_API_KEY']

smarter_csv_options = {
  convert_values_to_numeric: true,
  headers_in_file: true,
  col_sep: ',',
  chunk_size: 100,
  header_converters: :symbol,
}

SmarterCSV.process(csv_file_path, smarter_csv_options) do |chunk|
  chunk.each do |c|
    data = {
      name:      c[:station_name],
      latitude:  c[:lat],
      longitude: c[:lon],
    }
    p data

    station = Parse::Object.new('Station')
    station['name']     = data[:name];
    station['location'] = Parse::GeoPoint.new({
      latitude:  data[:latitude],
      longitude: data[:longitude],
    })
    result = station.save
    puts "    => #{result}"
  end
end