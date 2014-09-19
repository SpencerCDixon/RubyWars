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
require_relative 'lib/power_ups/speed'


NAME = ARGV[0] || "Anonymous"

class GameWindow < Gosu::Window
  SCREEN_WIDTH = 800
  SCREEN_HEIGHT = 600
  POWER_UP_FREQUENCY = 3
  POWER_UP_LENGTH = 10

  include Keys
  attr_reader :timer, :player
  attr_accessor :enemies, :large_font

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    @background = Background.new(self, 0, 0)
    @player = Player.new(self, 400, 50)
    @power_ups = [SpeedBoost.new(self, rand(800), rand(600))]
    @current_boost = []

    # Enemies + Bullets
    @spawn_rate = 5.0
    @spawn_acc = 15.0
    @enemies = []
    @bullets = []

    # Timer & Counters
    @timer = Timer.new
    @counter_spawn = 0
    @counter_rate = 0

    # Game & Player Mechanics
    @name = NAME
    @score = 0
    @state = :menu

    # Font and Menu
    @large_font = Gosu::Font.new(self, "Arial", SCREEN_HEIGHT / 6)
    @small_font = Gosu::Font.new(self, "helvetica", 20)
  end

  def draw
    @background.draw

    @player.draw
    @enemies.each {|e| e.draw} if !@enemies.empty?
    @small_font.draw("Min: #{@timer.minutes} Sec: #{@timer.seconds}, #{@spawn_rate}, E = #{@enemies.size}", 100, 30, 5, 1.0, 1.0, 0xffffffff)
    @small_font.draw("#{@score}", 345, 30, 5, 1.0, 1.0, 0xffffffff)
    @bullets.each {|b| b.draw} if !@bullets.empty?

    if @state == :lose
      draw_text_centered("Game Over", large_font)
    end

    if timer.seconds >= POWER_UP_FREQUENCY && timer.seconds <= (POWER_UP_FREQUENCY + POWER_UP_LENGTH)
      @dropped_power_up = @power_ups.first
      @dropped_power_up.draw
    end
    power_up_draw? if !@dropped_power_up.nil?
  end

  def update
    unless @state == :lose
      @counter_spawn += 1
      @counter_rate += 1
      @player.update
      @timer.update
      @enemies.each {|e| e.update}
      @bullets.each {|b| b.update} if !@bullets.empty?

      summon_enemies
      enemy_collision?
      bullet_collision?
      power_up_boost? if !@dropped_power_up.nil?
    end
  end

  def summon_enemies
    if @counter_spawn >= (@spawn_rate * 60.0)
      @enemies << Enemy.new(self, rand(200), rand(200), @player)
      @counter_spawn = 0
    end
    if @counter_rate >= (@spawn_acc * 60.0)
      @spawn_rate -= 0.7 if @spawn_rate > 0.7
      @counter_rate = 0
    end
  end

  def enemy_collision?
    @enemies.any? do |enemy|
     if enemy.bounds.intersects?(@player.bounds)
       @state = :lose
     end
    end
  end

  def bullet_collision?
    unless @bullets.empty?
      @bullets.any? do |bullet|
        @enemies.any? do |enemy|
          if bullet.bounds.intersects?(enemy.bounds)
            @enemies.delete(enemy)
            @score += (100 * (@timer.seconds / 5))
          end
        end
      end
    end
  end

  def power_up_draw?
    if @dropped_power_up.bounds.intersects?(@player.bounds)
      puts "Power up!"
      @small_font.draw("gem install rails...", 300, 300, 5, 1.0, 1.0, 0xffffffff)
    end
  end

  def power_up_boost?
    if @dropped_power_up.bounds.intersects?(@player.bounds)
      @current_boost << @dropped_power_up
      @current_boost.first.boost
      @current_boost.delete(@dropped_power_up)
    end
  end

  # Building Menu
  def draw_text_centered(text, font)
    x = (SCREEN_WIDTH - font.text_width(text)) / 2
    y = (SCREEN_HEIGHT - font.height) / 2
    color = Gosu::Color::RED

    draw_text(x, y, text, font, color)
  end

  def draw_text(x, y, text, font, color)
    font.draw(text, x, y, 3, 1, 1, color)
  end


end

GameWindow.new.show
