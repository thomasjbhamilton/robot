require_relative 'spec_helper'

describe Robot do

  before :each do
    @robot = Robot.create
  end

  describe "self build" do
    it "builds a robot and adds it to robots_list" do
      expect(Robot.robots_list.length).to eq(1)
    end
  end
end
