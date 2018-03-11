require_relative 'spec_helper'
require 'pry'

describe "Reservation" do
  # Test data to use in the following test
  describe "#initialize" do
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

    it "can calculate days booked" do
      test_reservation = Hotel::Reservation.new(@fake_reservation)

      test_reservation.length_of_stay.must_equal 4
    end
  end

  describe "#calculate_cost" do
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
    it "can accurately calculate the cost for a reservation" do
      test_reservation = Hotel::Reservation.new(@fake_reservation)

      test_reservation.calculate_cost.must_equal 800
    end

    it "does not charge for the check_out date" do
      test_reservation = Hotel::Reservation.new(@fake_reservation)

      test_reservation.calculate_cost.wont_equal 1000
    end
  end

  describe "#overlap?" do
    before do
      @start_date_1 = Date.new(2018,3,1)
      @end_date_1 = @start_date_1 + 4
      @fake_reservation_1 = {
        res_id: 1,
        room_id: 03,
        check_in: @start_date_1,
        check_out: @end_date_1,
      }
      @reservation = Hotel::Reservation.new(@fake_reservation_1)
    end
    # Completely before
    it "returns false for dates completely before" do
      start_date_2 = @start_date_1 - 3
      end_date_2 = @start_date_1 - 1

      @reservation.overlap?(start_date_2, end_date_2).must_equal false
    end

    # Completely after
    it "returns false for dates completely after" do
      start_date_2 = @end_date_1 + 1
      end_date_2 = @end_date_1 + 3

      @reservation.overlap?(start_date_2, end_date_2).must_equal false
    end

    # Ends on the checkin date
    it "returns false if the start date falls on an end date of a previous reservation" do
      start_date_2 = @end_date_1 + 0
      end_date_2 = @end_date_1 + 3

      @reservation.overlap?(start_date_2, end_date_2).must_equal false
    end

    #  Starts on the checkout date
    it "returns false if the end date falls on the start date of a previous reservation" do
      start_date_2 = @start_date_1 - 3
      end_date_2 = @start_date_1 - 0

      @reservation.overlap?(start_date_2, end_date_2).must_equal false
    end

    # overlap?s in the front
    it "returns true if the start date falls within a previous reservation" do
      start_date_2 = @start_date_1 + 1
      end_date_2 = @end_date_1 +1

      @reservation.overlap?(start_date_2, end_date_2).must_equal true
    end

    # overlap?s in the back
    it "returns true if the end date falls within a previous reservation" do
      start_date_2 = @start_date_1 - 4
      end_date_2 = @start_date_1 + 1

      @reservation.overlap?(start_date_2, end_date_2).must_equal true
    end

    # Completely contained
    it "returns true if the new reservation starts and ends within a previous reservation" do
      start_date_2 = @start_date_1 + 1
      end_date_2 = @end_date_1 - 1

      @reservation.overlap?(start_date_2, end_date_2).must_equal true
    end

    # Completely containing
    it "returns true if the new reservation tries to overlap? an exsisting reservation" do
      start_date_2 = @start_date_1 - 1
      end_date_2 = @end_date_1 + 1

      @reservation.overlap?(start_date_2, end_date_2).must_equal true
    end

    # The same dates as the previous reservation
    it "returns true if the new reservation is the exact same dates as a previous reservation" do
      start_date_2 = @start_date_1 + 0
      end_date_2 = @end_date_1 + 0

      @reservation.overlap?(start_date_2, end_date_2).must_equal true
    end

  end
end
