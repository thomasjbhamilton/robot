require 'pry'

class Robot

  class RobotAlreadyDeadError < RuntimeError
  end

  class UnattackableEnemy < RuntimeError
  end

  @@robots_list = []
  CAPACITY = 250

  attr_reader :position, :items, :hitpoints, :health
  attr_accessor :equipped_weapon, :shield_points

  def initialize(position=[0,0], items=[], health=100, hitpoints=5, equipped_weapon=nil)
    @position = position
    @items = items
    @health = health
    @hitpoints = hitpoints
    @equipped_weapon = equipped_weapon
    @shield_points = 50
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(item)

    if item.is_a?(BoxOfBolts) && self.health <= 80
      item.feed(self)
      return true
    end

    if (items_weight + item.weight) <= CAPACITY
      @items << item
      if item.is_a? Weapon
        @equipped_weapon = item
      end
      true
    else
      false
    end
  end

  def items_weight
    items_weight = 0
    @items.each { |item| items_weight += item.weight }
    items_weight
  end

  def wound(num)
    if @shield_points > 0 && @shield_points > num
       @shield_points -= num
    elsif @shield_points > 0 && @shield_points < num
     left_attack = (@shield_points -= num).abs
      if (@health - left_attack) < 0
        @health = 0
      else
        @health -= left_attack
      end
    else
      if (@health - num) < 0
        @health = 0
      else
        @health -= num
      end
    end
  end

  def heal(number)
    if (@health + number) >= 100
      @health = 100
    else
      @health += number
    end
  end

  def heal!(number)
    raise RobotAlreadyDeadError, "you're dead, theres no comming back" if @health == 0
    if (@health + number) >= 100
      @health = 100
    else
      @health += number
    end
  end

  def can_attack?(victim)
    if @equipped_weapon
      ((@position[0] - victim.position[0]).abs <= @equipped_weapon.range) && ((@position[1] - victim.position[1]).abs <= @equipped_weapon.range)
    else
      ((@position[0] - victim.position[0]).abs < 2) && ((@position[1] - victim.position[1]).abs < 2)
    end
  end

  def attack(enemy)
    if can_attack?(enemy)
      @equipped_weapon ? @equipped_weapon.hit(enemy) : enemy.wound(@hitpoints)
      if @equipped_weapon.is_a?(Grenade)
        @equipped_weapon = nil
      end
    end
  end

  def attack!(enemy)
    raise UnattackableEnemy, "Can only attack robots!" if enemy.class != Robot
    if @equipped_weapon == nil
      enemy.wound(@hitpoints)
    else
      @equipped_weapon.hit(enemy)
    end
  end

  def self.create
    robot = Robot.new
    @@robots_list << robot
    robot
  end

  def self.robots_list
    @@robots_list
  end

  def self.robot_position
    bots= @@robots_list.map do |robot|
      robot.position
    end
    bots
  end

  def hide_self
    @@robots_list.select{|r| r != self}
  end


  def scan
    hide_self.map {|r| r.position}.map do |other|
      if (position[0] - other[0]).abs <= 1 && (position[1] - other[1]).abs <= 1
        other
      end
    end
  end
end
