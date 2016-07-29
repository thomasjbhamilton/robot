class Grenade < Weapon
  def initialize
    super("Grenade", 40, 15, 2)
  end

  def discard(robot)
    robot.weapon = nil
  end

end
