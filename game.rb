# Ruby Wars V1

require 'gosu'
require_relative 'lib/bounding_box'
require_relative 'lib/player'
require_relative 'lib/keys'
require_relative 'lib/enemies'

class GameWindow < Gosu::Window
  include Keys
  attr_accessor :enemies

  def initialize
    super 800, 600, false

    @player = Player.new(self, 400, 50)
    @ai_on = Gosu::Font.new(self, "helvetica", 20)
    @collision = 10
    @enemies = []

    generate_enemies
  end

  def generate_enemies
    20.times do
      @enemies << Enemy.new(self, rand(800), rand(300))
    end
  end

  def draw
    @player.draw
    @enemies.each {|e| e.draw}
    @ai_on.draw("#{@collision}", 345, 30, 0, 1.0, 1.0, 0xffffffff)
  end

  def update
    @player.update
    @enemies.each {|e| e.update}

    enemy_collision?
  end

  def enemy_collision?
    @enemies.each do |enemy|
      if enemy.collide?(@player.x, @player.y) == true
        @collision = true
      elsif enemy.collide?(@player.x, @player.y) == false
        @collision = false
      end
    end
  end

end

window = GameWindow.new
window.show
