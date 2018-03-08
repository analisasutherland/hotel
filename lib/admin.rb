require_relative 'reservation'
require 'pry'

module Hotel
  # SETTING ROOM_LIST AND ROOM_RATE TO CONSTANTS
  ROOM_LIST = Array.new(20) {|i| i.to_i + 1 }
  ROOM_RATE = 200
  UNAVAILABLE_ROOM = "No available rooms."

  class Admin
    attr_accessor :reservations

    def initialize
      # list of the all_reservations
      # (starts with none, maybe empty array)
      @reservations = []
    end

    #M: Check_availble w/ list of reservation by dates (may use reservation list). Maybe Call HM2?
    def check_availability
      room_id = nil
      # Checking if there are no previous reservations
      if @reservations.length == 0
        room_id = ROOM_LIST.sample
      elsif
        # checking if there are no rooms available
        ROOM_LIST.each do |id|
          @reservations.each do |res|
            if
              res.room_id != id
              return room_id
            end
            return UNAVAILABLE_ROOM
          end
        end
      end
    end


    #M: create_reservation (can get cost in this) Can Possibly Call HM1
    # def create_reservation
    #
    # end


    #HM1: Calculcate Cost
    # def calculate_cost
    #
    # end


    # HM2: Needs to check if dates overlap, take in dates and determine overlap with self (boolean?)
    # def check_for_overlap
    #
    # end

    #M: pull up a list of all reservations by date
    # def list_reservations
    #
    # end


  end
end
