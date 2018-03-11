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
    # def check_availability(start_date, end_date)
    #   # WILL NEED TO ADD CHECK IN AND CHECK OUT ARGUMENTS IN ORDER TO CALL HM2 OVERLAP
    #   available_rooms = []
    #   room_id = nil
    #   # Checking if there are no previous reservations
    #   if @reservations.length == 0
    #     room_id = ROOM_LIST.sample
    #   else
    #     # checking if there are no rooms available
    #     @reservations.each do |reservation|
    #       reservation.overlap?(start_date, end_date)
    #       if false
    #         available_rooms << reservation.id
    #
    #         room_id = available_rooms.sample
    #         return room_id
    #       end
    #       if available_rooms.length == 0
    #         return UNAVAILABLE_ROOM
    #       end
    #     end
    #   end
  end
end

# CURRENTLY WORKING: 
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
