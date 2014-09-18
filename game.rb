# Ruby Wars V1
require 'gosu'

require_relative 'lib/bounding_box'
require_relative 'lib/player'
require_relative 'lib/keys'
require_relative 'lib/enemies'
require_relative 'lib/background'
require_relative 'lib/bullet'
require_relative 'lib/timer'


class GameWindow < Gosu::Window
  SCREEN_WIDTH = 800
  SCREEN_HEIGHT = 600

  include Keys
  attr_accessor :enemies

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    @background = Background.new(self, 0, 0)

    @player = Player.new(self, 400, 50)
    @ai_on = Gosu::Font.new(self, "helvetica", 20)
    @collision = 10

    @enemies = []
    @bullets = []
    generate_enemies

    @timer = Timer.new
    @show_timer = Gosu::Font.new(self, "helvetica", 20)
  end

  def generate_enemies
    10.times do
      @enemies << Enemy.new(self, rand(800), rand(600))
    end
  end

  def gen_e
    @spawn_rate = 10
    @spawn_acc = 60

    case
    when @timer.seconds % @spawn_rate == 0
      @enemies << Enemy.new(self, rand(800), rand(600))
    when

    end

  end



  def draw
    @background.draw
    @player.draw
    @enemies.each {|e| e.draw}
    @show_timer.draw("#{@timer.seconds}", 100, 30, 5, 1.0, 1.0, 0xffffffff)
    @ai_on.draw("#{@collision}", 345, 30, 5, 1.0, 1.0, 0xffffffff)
    !@bullets.empty? ? @bullets.each {|b| b.draw} : nil
  end

  def update
    @player.update
    @timer.update
    @enemies.each {|e| e.update}
    if !@bullets.empty? then @bullets.each {|b| b.update} end

    enemy_collision?
    bullet_collision?
  end

  def enemy_collision?
    @enemies.any? do |enemy|
      enemy.collide?(@player.x, @player.y) ? @collision = true : @collision = false
    end
  end

  def bullet_collision?
    unless @bullets.empty?
      @bullets.any? do |bullet|
        @enemies.any? do |enemy|
          if bullet.collide?(enemy.x, enemy.y) then @enemies.delete(enemy) end
        end
      end
    end
  end

end

GameWindow.new.show
