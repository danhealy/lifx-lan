# Auto-off script
#
# This script will turn a light off after 10 seconds when it has detected it has turned on.
# To run: bundle; bundle ruby auto-off.rb [light label]

require 'lifx-lan'

AUTO_OFF_DELAY = 10

label = ARGV.first
lifx = LIFX::LAN::Client.lan
lifx.discover! do
  label ? lifx.lights.with_label(label) : lifx.lights.first
end

light = label ? lifx.lights.with_label(label) : lifx.lights.first

puts "#{light} will be automatically turned off after #{AUTO_OFF_DELAY} seconds"

thr = Thread.new do
  loop do
    if light.on? && !(@off_thr && @off_thr.alive?)
      puts "Light detected on. Turning off in #{AUTO_OFF_DELAY}"
      @off_thr = Thread.new do
        sleep AUTO_OFF_DELAY
        light.turn_off
        puts "Turning off"
      end
    end
    sleep 1
  end
end

thr.join
