require_relative 'spec_helper'

describe Batteries do
  before :each do
    @battery = Batteries.new
  end

  it "has name 'Box of battery'" do
    expect(@battery.name).to eq("Batteries")
  end

  it "has 25 weight" do
    expect(@battery.weight).to eq(25)
  end

  describe "#recharge" do
    before :each do
      @robot = Robot.new
    end

    it "heals the robot's health 20pts" do
      @robot.wound(15)
      @battery.recharge(@robot)
      expect(@robot.shield_points).to eq(50)
    end
  end
end
