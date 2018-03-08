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
      # WILL NEED TO ADD CHECK IN AND CHECK OUT ARGUMENTS IN ORDER TO CALL HM2 OVERLAP
      room_id = nil
      # Checking if there are no previous reservations
      if @reservations.length == 0
        room_id = ROOM_LIST.sample
      elsif
        # checking if there are no rooms available
        ROOM_LIST.each do |id|
          @reservations.each do |res|
            #CALL HM2 FOR OVERLAP CHECK
            if
              res.room_id != id
              return room_id
            end
            return UNAVAILABLE_ROOM
          end
        end
      end
    end

    # CURRENTLY WORKING: WAITING FOR OVERLAP method
    # #M: create_reservation (can get cost in this) Can Possibly Call HM1
    # def create_reservation (check_in, check_out)
    #   room_id = check_availability
    #   res_id = Random.new_seed
    #   new_reservation = Hotel::Reservation.new({
    #     res_id: res_id,
    #     room_id: room_id,
    #     check_in: Date.parse(check_in),
    #     check_out: Date.parse(check_out)
    #     })
    #
    #   @reservations << new_reservation
    #   return new_reservation
    # end

    #M: pull up a list of all reservations by date
    # def list_reservations
    #
    # end


  end
end
