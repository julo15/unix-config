#!/usr/bin/ruby

require 'optparse'

$log_output = StringIO.new
def log_v(line)

  $log_output.puts line

end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: jump [options]"

  opts.on('-l[PATTERN]', '--list[=PATTERN]', "List destinations") do |pattern|
    log_v "Pattern is #{pattern}!"
    options[:list] = true
  end

  opts.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
    options[:verbose] = v
  end
end.parse!

if (!options[:list] && ARGV.length != 1) then
  raise 'Need to specify a destination'
end

pattern = ARGV[0]

dest_file_path = File.join(ENV['HOME'], '.jumpdests')

destinations = Hash.new

log_v 'Start'

begin
  File.readlines(dest_file_path).each do |line|
    log_v "Parsing: #{line}"
    key, path = line.split(' ', 2)
    # TODO: Add empty key/path detection
    destinations[key.strip] = path.strip
  end
rescue Errno::ENOENT
  raise "Missing destination file (#{dest_file_path})"
end

log_v destinations

log_v 'End'

path = nil

if (destinations.has_key?(pattern)) then
  log_v "Found #{pattern}"
  path = destinations[pattern]

else
    search = destinations.keys.grep(/#{pattern}/)
    if (search.length == 1) then
      log_v "Found inexact #{pattern}"
      path = destinations[search[0]]
    elsif (options[:list]) then
      log_v ""
      log_v "Destinations:"
      destinations.each do |key, path|
          log_v "#{key}\t\t#{path}"
      end
      raise $log_output.string
    else
      if (search.length == 0) then
        log_v "#{pattern} not found"
      else
        log_v "Multiple matches found for #{pattern}"
        search.each do |key|
          log_v "\t#{key}\t\t#{destinations[key]}"
        end
      end
      raise $log_output.string
    end
end


# Replace ~ with ENV['HOME']
path = path.gsub(/^~/, ENV['HOME'])
log_v "Switching to #{path}"
puts path
