require_relative 'spec_helper'

describe "Reservation" do
  # Test data to use in the following tests
  before do
    start_date = Date.new(2018,3,1)
    check_out_date = Date.new(2018,3,5)

    @fake_reservation = {
      res_id: 1,
      ROOM_ID: 03,
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
  end
end
