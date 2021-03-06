#!/usr/bin/ruby

require 'optparse'

$log_output = StringIO.new
def log_v(line)
  $log_output.puts line unless !$options[:verbose]
end

def log_i(line)
  $log_output.puts line
end

def show_usage_and_exit
  raise "\n\n#{opts.to_s}"
end

$options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: jump [options]"

  opts.on('-l[PATTERN]', '--list[=PATTERN]', "List destinations") do |pattern|
    log_v "Pattern is #{pattern}!"
    $options[:list] = true
  end

  opts.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
    $options[:verbose] = v
  end

  opts.on_tail("-h", "--help", "Show this message") do
    raise "\n\n#{opts.to_s}"
  end
end.parse!

if (!$options[:list] && ARGV.length != 1) then
  raise 'Need to specify a destination. Run with -h for arguments'
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
  log_i "Found #{pattern}"
  path = destinations[pattern]

else
    search = destinations.keys.grep(/#{pattern}/)
    if (search.length == 1) then
      log_i "Found inexact #{pattern}"
      path = destinations[search[0]]
    elsif ($options[:list]) then
      log_i ""
      log_i ""
      log_i "Destinations:"
      destinations.each do |key, path|
          log_i "  #{key}\t\t#{path}"
      end
      raise $log_output.string
    else
      if (search.length == 0) then
        log_i "#{pattern} not found"
      else
        log_i "Multiple matches found for #{pattern}"
        search.each do |key|
          log_i "\t#{key}\t\t#{destinations[key]}"
        end
      end
      raise $log_output.string
    end
end

# Replace ~ with ENV['HOME']
path = path.gsub(/^~/, ENV['HOME'])
puts path
