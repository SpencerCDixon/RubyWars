class Player
  attr_accessor :x, :y, :move_up, :move_down, :move_right, :move_left, :player_speed, :bombs, :binding_pry, :bullet_speed_boost
  attr_reader :bounds, :help_request

  def initialize(window, x, y)
    @player_image = Gosu::Image.new(window, 'img/player_small.png')
    @window = window
    @x = x
    @y = y
    @bombs = 0
    @binding_pry = 0
    @bullet_speed_boost = 0

    @player_speed = 7

    @move_up = false
    @move_down = false
    @move_right = false
    @move_left = false

    @shooting = Gosu::Sample.new(window, 'music/Shooting1 2.m4a')
    @help_request = Gosu::Sample.new(window, 'music/Help_Request.wav')
  end

  def bounds
    BoundingBox.new(@x, @y, 44, 37)
  end

  def draw
    @player_image.draw(@x, @y, 1)
  end

  def fire(direction, speed_boost = 0)
    x_speed = 0.0
    y_speed = 0.0

    x_speed += 1.0 if direction == :left
    x_speed -= 1.0 if direction == :right
    y_speed += 1.0 if direction == :down
    y_speed -= 1.0 if direction == :up

    bullet_speed = 10 + speed_boost
    @shooting.play(0.1) if @window.sfx
    Bullet.new(@window, x, y, x_speed, y_speed, bullet_speed)
  end

  def update
    if move_up
      unless y <= 0
        @y += -@player_speed
      end
    end

    if move_down
      unless y >= (600 - @player_image.height)
        @y += @player_speed
      end
    end

    if move_right
      unless x >= (800 - @player_image.width)
        @x += @player_speed
      end
    end

    if move_left
      unless x <= 0
        @x += -@player_speed
      end
    end
  end


end
