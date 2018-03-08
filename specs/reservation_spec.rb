require_relative 'spec_helper'

describe "Reservation" do
  # Test data to use in the following tests
  before do
    start_date = Date.new(2018,3,1)
    check_out_date = Date.new(2018,3,5)

    @fake_reservation = {
      res_id: 1,
      room_id: 03,
      check_in: start_date,
      check_out: check_out_date,
    }
  end

  describe "#initialize" do
    it "creates an instance of Reservation" do
      test_reservation = Hotel::Reservation.new(@fake_reservation)

      test_reservation.must_be_kind_of Hotel::Reservation
    end

    it "keeps track of reservation id" do
      id = @fake_reservation[:res_id]

      test_reservation = Hotel::Reservation.new(@fake_reservation)

      test_reservation.must_respond_to :res_id

      test_reservation.res_id.must_equal id
    end

    it "keeps track of room_id" do
      test_room_id = @fake_reservation[:room_id]

      test_reservation = Hotel::Reservation.new(@fake_reservation)

      test_reservation.must_respond_to :room_id

      test_reservation.room_id.must_equal test_room_id
    end

    it "keeps track of check in date" do
      test_check_in = @fake_reservation[:check_in]

      test_reservation = Hotel::Reservation.new(@fake_reservation)

      test_reservation.must_respond_to :check_in

      test_reservation.check_in.must_equal test_check_in
    end

    it "keeps track of check out date" do
      test_check_out = @fake_reservation[:check_out]

      test_reservation = Hotel::Reservation.new(@fake_reservation)

      test_reservation.must_respond_to :check_out

      test_reservation.check_out.must_equal test_check_out
    end

    it "will raise an error if check in and check out are not dates" do
      @bad_date_reservation = {
        res_id: 1,
        room_id: 03,
        check_in: nil,
        check_out: nil,
      }
      proc{ Hotel::Reservation.new(@bad_date_reservation)}.must_raise ArgumentError
    end

    it "must have a positive integer as an ID" do
      start_date = Date.new(2018,3,1)
      check_out_date = Date.new(2018,3,5)

      bad_id_reservation = {
        res_id: "not an integer",
        room_id: 03,
        check_in: start_date,
        check_out: check_out_date,
      }
      proc{Hotel::Reservation.new(bad_id_reservation)}.must_raise ArgumentError

      negative_id_reservation = {
        res_id: 1,
        room_id: -03,
        check_in: start_date,
        check_out: check_out_date,
      }
      proc{Hotel::Reservation.new(negative_id_reservation)}.must_raise ArgumentError
    end
  end

  describe "#length_of_stay" do
    it "can calculate days booked" do
      test_reservation = Hotel::Reservation.new(@fake_reservation)

      test_reservation.length_of_stay.must_equal 4
    end
  end

  describe "#calculate_cost" do
    it "can accurately calculate the cost for a reservation" do
      test_reservation = Hotel::Reservation.new(@fake_reservation)

      test_reservation.calculate_cost.must_equal 800
    end
    # it "can return 0 if no nights are reserved" do
    #
    # end
    #
    # it "does not charge for the check_out date" do
    #
    # end
  end
end
