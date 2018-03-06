module Hotel
  class Reservation

    attr_reader :res_id
    # Want all reservations to have/store:
    # Reservation Id, Room Id, check_in, check_out
    def initialize(input)
      @res_id = input[:res_id]
    end

  end

end
