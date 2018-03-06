module Hotel
  class Reservation

    attr_reader :res_id, :room_id, :check_in, :check_out
    # Want all reservations to have/store:
    # Reservation Id, Room Id, check_in, check_out
    def initialize(input)
      @res_id = input[:res_id]
      @room_id = input[:room_id]
      @check_in = input[:check_in]
      @check_out = input[:check_out]

      if @check_in.class != Date || @check_out.class != Date
        raise ArgumentError.new("You must provide dates (got #{input[:check_in]} and #{input[:check_out]})")
      end
    end

  end

end
