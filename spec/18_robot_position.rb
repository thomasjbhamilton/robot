require_relative 'spec_helper'

describe Robot do

  before :each do
    Robot.class_variable_set :@@robots_list, []
    @robot = Robot.create
    @robot2 = Robot.create
    @robot3 = Robot.create
  end

  describe "#scan" do
    it "gives array of robots immediately next to subject" do
      @robot2.move_left
      @robot3.move_down
      expect(@robot.scan).to be == [[-1, 0], [0, -1]]
    end
  end
end
