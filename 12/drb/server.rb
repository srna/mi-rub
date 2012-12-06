#!/usr/bin/env ruby
require 'drb'
require_relative 'counter'
 
 
 DRb.start_service 'druby://:9000', Counter.new
 puts "Server running at #{DRb.uri}"
 
begin
  DRb.thread.join
rescue Interrupt
ensure
  DRb.stop_service
end