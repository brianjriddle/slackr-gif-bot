#!/usr/bin/env ruby
require 'fileutils'

# renumerate and copy the files to a temp directory
# when done replace the original with the TMP

orig_dir = File.absolute_path ARGV[0]
temp_dir = "#{File.dirname(orig_dir)}_TMP"
gifs = Dir.glob(orig_dir + "/*.gif")
gifs.each_with_index do |file,i|
  FileUtils.mkdir_p temp_dir
  new_file = "#{temp_dir}/#{i}.gif"
  puts "moving #{file} to #{new_file}" 
  FileUtils.mv file, new_file 
end
FileUtils.rm_rf orig_dir
FileUtils.mv temp_dir, orig_dir
