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
require_relative 'lib/power_ups/bombs'
require_relative 'lib/power_ups/binding_pry'
require_relative 'menu'

NAME = ARGV[0] || "Anonymous"

class GameWindow < Gosu::Window
  SCREEN_WIDTH = 800
  SCREEN_HEIGHT = 600

  include Keys
  attr_reader :timer, :player, :name, :score, :music, :sfx
  attr_accessor :enemies, :large_font

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    @background = Background.new(self, 0, 0)
    @player = Player.new(self, 400, 50)

    # Power Up
    @power_ups = summon_power_ups
    @dropped_power_up = @power_ups.select {|o| o.unused? == true}.first
    @current_boost = []
    @pwr_up_frequency = 25  * 60
    @pwr_up_spawn_time = 5 * 60
    @p_up_counter = 0

    # Enemies + Bullets
    @spawn_rate = 4.0
    @spawn_acc = 15.0
    @enemies = []
    @bullets = []

    # Game & Player Mechanics
    @name = NAME
    @score = 0
    @state = :menu

    # Timer & Counters
    @timer = Timer.new
    @counter_spawn = 0
    @counter_rate = 0

    # Font and Menu
    @music = true
    @sfx = true
    @menu = Menu.new(self, 0, 0, @music, @sfx)
    @large_font = Gosu::Font.new(self, "Futura", SCREEN_HEIGHT / 10)
    @medium_font = Gosu::Font.new(self, "Futura", SCREEN_HEIGHT / 22)
    @small_font = Gosu::Font.new(self, "Futura", SCREEN_HEIGHT / 30)
    @game_end = nil
  end

  def draw
    @menu.draw if @state == :menu

    if @state != :menu
      if @state == :running
        @background.draw
        @player.draw
        @enemies.each {|e| e.draw} if !@enemies.empty?
        @bullets.each {|b| b.draw} if !@bullets.empty?
        @p_up_counter += 1

        # Drop Power Ups
        if @p_up_counter >= @pwr_up_frequency && @p_up_counter <= @pwr_up_frequency  + @pwr_up_spawn_time
          @dropped_power_up.draw
          if @p_up_counter == @pwr_up_frequency + @pwr_up_spawn_time
            @p_up_counter = 0
            @dropped_power_up = @power_ups.select {|o| o.unused? == true}.first
          end
        end

        # Game Stats Drawings
        draw_text(360, 10,"#{@score}", @medium_font, 0xffffffff)
        draw_text(650, 7,"Help Requests x ", @small_font, 0xffffffff)
        draw_text(770, 7,"#{@player.bombs}", @small_font, Gosu::Color::RED)
        draw_text(650, 24,"Binding Prys   x ", @small_font, 0xffffffff)
        draw_text(770, 24,"#{@player.binding_pry}", @small_font, Gosu::Color::RED)
        draw_text(770, 54,"#{@timer.seconds}", @small_font, Gosu::Color::BLUE)

      end

      # Post score online and reset game after 5 seconds
      if @state == :lose
        draw_text_centered("Game Over", large_font)
        @background.draw
        if @game_end == nil
          @game_end = Timer.new
        end
        @game_end.update
        if @game_end.seconds >= 5
          reset(:menu)
        end
      end
    end
  end

  def update
    menu_action = @menu.update

    if menu_action == "start"
      @state = :running
    elsif menu_action == "mtoggle"
      @music == true ? @music = false : @music = true
    elsif menu_action == "sfxtoggle"
      @sfx == true ? @sfx = false : @sfx = true
    end
    @menu.menu_action = nil

    if @state == :running
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

    if @state == :lose
      @enemies.each {|e| e.state == :pause}
    end
  end

  def summon_enemies
    case
    when timer.minutes >= 4
      if @counter_spawn >= (@spawn_rate * 60.0)
        @enemies << spawn
        @enemies << spawn
        @enemies << spawn
        @enemies << spawn
        @counter_spawn = 0
      end
      if @counter_rate >= (@spawn_acc * 60.0)
        @spawn_rate -= 0.4 if @spawn_rate > 0.7
        @counter_rate = 0
      end
    when timer.minutes >= 2
      if @counter_spawn >= (@spawn_rate * 60.0)
        @enemies << spawn
        @enemies << spawn
        @enemies << spawn
        @counter_spawn = 0
      end
      if @counter_rate >= (@spawn_acc * 60.0)
        @spawn_rate -= 0.4 if @spawn_rate > 0.7
        @counter_rate = 0
      end
    when timer.minutes >= 1
      if @counter_spawn >= (@spawn_rate * 60.0)
        @enemies << spawn
        @enemies << spawn
        @counter_spawn = 0
      end
      if @counter_rate >= (@spawn_acc * 60.0)
        @spawn_rate -= 0.4 if @spawn_rate > 0.7
        @counter_rate = 0
      end
    when timer.seconds >= 0
      if @counter_spawn >= (@spawn_rate * 60.0)
        @enemies << spawn
        @counter_spawn = 0
      end
      if @counter_rate >= (@spawn_acc * 60.0)
        @spawn_rate -= 0.4 if @spawn_rate > 0.7
        @counter_rate = 0
      end
    end
  end

  def e_top_left
    Enemy.new(self, rand(100), rand(100), @player)
  end

  def e_top_right
    Enemy.new(self, (rand(100) + 700), rand(100), @player)
  end

  def e_bot_right
    Enemy.new(self, (rand(100) + 700), (rand(100) + 500), @player)
  end

  def e_bot_left
    Enemy.new(self, rand(100), (rand(100) + 500), @player)
  end

  def spawn
    [e_bot_left, e_top_left, e_top_right, e_bot_right].sample
  end

  def summon_power_ups
    power_ups = []
    5.times do
      power_ups << SpeedBoost.new(self, rand(700), rand(500))
    end
    10.times do
      power_ups << PryBoost.new(self, rand(700), rand(500))
    end
    10.times do
      power_ups << BombBoost.new(self, rand(700), rand(500))
    end
    power_ups.shuffle!
    return power_ups
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
            enemy.death.play if sfx == true
            @score += (100 * (@timer.seconds / 5))
          end
        end
      end
    end
  end

  def power_up_boost?
    if @dropped_power_up.bounds.intersects?(@player.bounds) && @dropped_power_up.unused?
      @dropped_power_up.boost(@player)
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

  def reset(state)
    @menu = Menu.new(self, 0, 0, @music, @sfx)
    @player = Player.new(self, 400, 50)
    @timer = Timer.new
    @power_ups = summon_power_ups
    @enemies = []
    @bullets = []
    @current_boost = []
    @score = 0
    @state = state
    @game_end = nil
  end
end

GameWindow.new.show
