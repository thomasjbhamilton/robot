require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe "#heal!" do
    it "increases health unless the Robot is dead, then it raises a RototAlreadyDead error" do
      @robot.wound(150)
      expect{ @robot.heal!(10) }.to raise_error(Robot::RobotAlreadyDeadError, "you're dead, theres no comming back")
    end
  end

  describe "#attack!" do
    it "won't attack if the enemy is a robot" do
      enemy = Laser.new
      expect{@robot.attack!(enemy)}.to raise_error(Robot::UnattackableEnemy, "Can only attack robots!")
    end
  end

end
