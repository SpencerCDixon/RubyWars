# Ruby Wars V1
require 'gosu'
require 'pry'

require_relative 'lib/bounding_box'
require_relative 'lib/player'
require_relative 'lib/keys'
require_relative 'lib/enemies'
require_relative 'lib/background'
require_relative 'lib/bullet'
require_relative 'lib/timer'

NAME = ARGV[0] || "Anonymous"

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

    #Enemies + Bullets
    @enemies = []
    @spawn_rate = 6
    @spawn_acc = 45
    @bullets = []

    # Timer & Counters
    @timer = Timer.new
    @show_timer = Gosu::Font.new(self, "helvetica", 20)
    @counter_spawn = 0
    @counter_rate = 0

    @name = NAME
    @score = 0
  end

  def summon_enemies
    if @counter_spawn >= (@spawn_rate * 60)
      @enemies << Enemy.new(self, rand(800), rand(600))
      @counter_spawn = 0
    end
    if @counter_rate >= (@spawn_acc * 60)
      @spawn_rate -= 1 if @spaw_rate > 1
      @counter_rate = 0
    end
  end


  def draw
    @background.draw
    @player.draw
    @enemies.each {|e| e.draw} if !@enemies.empty?
    @show_timer.draw("Min: #{@timer.minutes} Sec: #{@timer.seconds}, #{@spawn_rate}, E = #{@enemies.size}", 100, 30, 5, 1.0, 1.0, 0xffffffff)
    @ai_on.draw("#{@score}", 345, 30, 5, 1.0, 1.0, 0xffffffff)
    @bullets.each {|b| b.draw} if !@bullets.empty?
  end

  def update
    @counter_spawn += 1
    @counter_rate += 1
    @player.update
    @timer.update
    @enemies.each {|e| e.update}
    if !@bullets.empty? then @bullets.each {|b| b.update} end

    summon_enemies
    enemy_collision?
    bullet_collision?
  end

  def enemy_collision?
    @enemies.any? do |enemy|
      @collision -= 1 if enemy.collide?(@player.x, @player.y)
    end
  end

  def bullet_collision?
    unless @bullets.empty?
      @bullets.any? do |bullet|
        @enemies.any? do |enemy|
          if bullet.collide?(enemy.x, enemy.y)
            @enemies.delete(enemy)
            @score += 100
          end
        end
      end
    end
  end

end

GameWindow.new.show
