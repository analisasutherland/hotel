require_relative 'spec_helper'
require 'pry'
describe "Admin" do
  describe "#initialize" do
    before do
      @fake_admin = Hotel::Admin.new
    end

    it "is an instance of Admin" do
      @fake_admin.must_be_instance_of Hotel::Admin
    end

    it "starts with no previous reservations" do
      @fake_admin.reservations.length.must_equal 0
    end
  end

  describe "#check_availability" do
    before do
      @fake_admin = Hotel::Admin.new
      # Empty array with no reservations
      @reservations = []
      # Really full array that iterates over all room ids
      x = 0

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
    end
    it "can find a single room within ROOM_LIST" do
      check_in_test = Date.new(2018,3,3)
      check_out_test = check_in_test + 4

      room_id = @fake_admin.check_availability(check_in_test, check_out_test)

      room_id.must_be :>, 0
      room_id.must_be :<=, 20
    end

    it "alerts you when all rooms are full" do
      check_in_test = Date.new(2018,2,3)
      check_out_test = check_in_test + 4

      Hotel::ROOM_LIST.each do |room|
        @fake_admin.create_reservation(check_in_test, check_out_test)
      end

      proc{
        room_id = @fake_admin.check_availability(check_in_test, check_out_test)}.must_raise ArgumentError
      end

      it "if some rooms are taken, it assigns other rooms" do
        check_in_test = Date.new(2018,2,3)
        check_out_test = check_in_test + 9

        res_1 = @fake_admin.create_reservation(@fake_reservation_rm_id_1[:check_in], @fake_reservation_rm_id_1[:check_out])

        res_2 = @fake_admin.create_reservation(@fake_reservation_rm_id_2[:check_in], @fake_reservation_rm_id_2[:check_out])

        room_id = @fake_admin.check_availability(check_in_test, check_out_test)

        room_id.wont_equal res_1.room_id
        room_id.wont_equal res_2.room_id
      end
    end
  end

  describe "#create_reservation" do
    before do
      @fake_admin = Hotel::Admin.new

      @check_in_test = Date.new(2018,3,12)
      @check_out_test = Date.new(2018,3,17)
    end

    it "can create an instance of reservation" do
      @fake_admin.create_reservation(@check_in_test,@check_out_test).must_be_kind_of Hotel::Reservation
    end
  end
  # describe "list_reservations" do
