require_relative 'reservation'
require 'pry'

module Hotel
  # SETTING ROOM_ID AND ROOM_RATE TO CONSTANTS
  ROOM_ID = Array.new(20) {|i| i.to_i + 1 }
  ROOM_RATE = 200
end
