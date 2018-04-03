require_relative 'reservation'

module Hotel
  # SETTING ROOM_LIST AND ROOM_RATE TO CONSTANTS
  ROOM_LIST = Array.new(20) {|i| i.to_i + 1 }
  ROOM_RATE = 200

  class Admin
    attr_reader :reservations

    def initialize
      # list of the all_reservations
      # (starts with none, maybe empty array)
      @reservations = []
    end

    #M: Check_availble w/ list of reservation by dates (may use reservation list). Maybe Call HM2?
    def check_availability(start_date, end_date)
      # WILL NEED TO ADD CHECK IN AND CHECK OUT ARGUMENTS IN ORDER TO CALL HM2 OVERLAP
      available_rooms = ROOM_LIST.dup
      room_id = nil
      # Checking if there are no previous reservations
      if @reservations.length == 0
        room_id = ROOM_LIST.sample
        return room_id
      else
        # checking if there are no rooms available
        @reservations.each do |reservation|
          # FIXME:
          if reservation.overlap?(start_date, end_date)
            available_rooms.delete(reservation.room_id)
          end
        end
        if available_rooms.length == 0
          raise ArgumentError.new("All rooms are currently booked at this time #{start_date} - #{end_date}.")
        else
          room_id = available_rooms.sample
          return room_id
        end
      end
    end
    #M: create_reservation (can get cost in this) Can Possibly Call HM1
    def create_reservation(check_in,check_out)
      room_id = check_availability(check_in,check_out)
      res_id = Random.new_seed
      new_reservation = Hotel::Reservation.new({
        res_id: res_id,
        room_id: room_id,
        check_in: Date.parse(check_in.to_s),
        check_out: Date.parse(check_out.to_s)
        })
        @reservations << new_reservation
        return new_reservation
      end
    end
  end
