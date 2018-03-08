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

      # Checking to make sure that both reservation id and room id are positive integers
      if @res_id.class != Integer || @res_id <= 0
        raise ArgumentError.new("ID must be a number and positive. (got #{input[:res_id]})")
      end

      if @room_id.class != Integer || @room_id <= 0
        raise ArgumentError.new("ID must be a number and positive. (got #{input[:room_id]})")
      end
      # checking to make sure that check_in and check_out are instances of Date class
      if @check_in.class != Date || @check_out.class != Date
        raise ArgumentError.new("You must provide dates (got #{input[:check_in]} and #{input[:check_out]})")
      end
    end

    #IP:****************************
    #HM: Summarize days booked by using end_date and start_date to calculate nights stayed. Remember to account for the last day not being a paying day- Checking out that day
    def length_of_stay
      length_of_stay = (@check_out - @check_in)

      return length_of_stay
    end

    #HM1: Calculcate Cost
    def calculate_cost
      #IP:****************************
      nights_booked = length_of_stay
      cost = (nights_booked * ROOM_RATE)
      return cost
    end


    #NEXT TO DO***************************
    # HM2: Needs to check if dates overlap, take in dates and determine overlap with self (boolean?)
    # def check_for_overlap
    #
    # end
  end
end
