
require_relative 'spec_helper'

describe Robot do

  before :each do
    @robot = Robot.new
  end

  describe "#wound" do
    it "decreases shield points" do
      @robot.wound(20)
      expect(@robot.shield_points).to eq(30)
    end

    it "doesn't decrease health until sheild points are used up" do
      @robot.wound(40)
      expect(@robot.health).to eq(100)
    end

    it "decreases health points when shield is used up" do
      @robot.wound(60)
      expect(@robot.health).to eq(90)
    end
  end
end
