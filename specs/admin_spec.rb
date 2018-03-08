require_relative 'spec_helper'
require 'pry'
describe "Admin" do
  before do
    # Empty array with no reservations
    @reservations = []
    # Really full array that iterates over all room ids
    x = 0
    @full_reservations = []
    Hotel::ROOM_LIST.each do |room_id|
      @full_reservations <<  Hotel::Reservation.new({
        res_id: x + 1,
        room_id: room_id,
        check_in: Date.new(2018,2,1),
        check_out: Date.new(2018,2,5),
        })
      end



      @fake_reservation_no_rm = {
        res_id: 1,
        room_id: nil,
        check_in: Date.new(2018,3,1),
        check_out: Date.new(2018,3,5),
      }

      @fake_reservation_rm_id_1 = {
        res_id: 2,
        room_id: 1,
        check_in: Date.new(2018,2,1),
        check_out: Date.new(2018,2,5),
      }

      @fake_reservation_rm_id_2 = {
        res_id: 2,
        room_id: 2,
        check_in: Date.new(2018,2,1),
        check_out: Date.new(2018,2,5),
      }

      @fake_admin = Hotel::Admin.new
    end

    describe "#initialize" do
      it "is an instance of Admin" do
        @fake_admin.must_be_kind_of Hotel::Admin
      end

      it "starts with no previous reservations" do
        (@fake_admin).reservations.length.must_equal 0
      end
    end

    describe "#check_availability" do
      it "can find a single room within ROOM_LIST" do
        room_id = @fake_admin.check_availability

        room_id.must_be :>,0
        room_id.must_be :<,20
      end

      it "alerts you when all rooms are full" do
        @fake_admin.reservations = @full_reservations

        room_id = @fake_admin.check_availability

        room_id.must_equal "No available rooms."
      end

      it "if some rooms are taken, it assigns other rooms" do
        @reservations << Hotel::Reservation.new(@fake_reservation_rm_id_1)

        @reservations << Hotel::Reservation.new(@fake_reservation_rm_id_2)

        @fake_admin.reservations = @reservations

        room_id = @fake_admin.check_availability
        room_id.wont_equal 1 || 2
      end
    end
    # def create_reservation
    # RESERVATION.new(id, check_availability method for the rm id, end_date, start date)
    # @reservations << new reservation

    # it "can assign a room to a reservation" do
    #
    # end

    # describe "list_reservations" do
    #
    # end
end
