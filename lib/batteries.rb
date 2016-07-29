class Batteries < Item
  def initialize
    super("Batteries", 25)
  end

  def recharge(robot)
    robot.shield_points += 15
  end
end
