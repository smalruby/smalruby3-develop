#!/usr/bin/env ruby

require 'base64'

if ARGV.empty?
  puts "Usage: #{$0} <png_file_path>"
  exit 1
end

png_file_path = ARGV[0]

unless File.exist?(png_file_path)
  puts "Error: File not found: #{png_file_path}"
  exit 1
end

unless File.extname(png_file_path).downcase == '.png'
  puts "Error: File must be a PNG image: #{png_file_path}"
  exit 1
end

begin
  # Read the PNG file and encode it as Base64
  png_data = File.read(png_file_path)
  base64_data = Base64.strict_encode64(png_data)

  # Output the data URI
  puts "data:image/png;base64,#{base64_data}"
rescue => e
  puts "Error: Failed to process file: #{e.message}"
  exit 1
end