class Player
  attr_accessor :x, :y, :move_up, :move_down, :move_right, :move_left, :player_speed, :bombs
  attr_reader :bounds

  def initialize(window, x, y)
    @player_image = Gosu::Image.new(window, 'img/ruby_small.png')
    @window = window
    @x = x
    @y = y
    @bombs = 0

    @player_speed = 7

    @move_up = false
    @move_down = false
    @move_right = false
    @move_left = false

  end

  def bounds
    BoundingBox.new(@x, @y, 50, 50)
  end

  def draw
    @player_image.draw(@x, @y, 1)
  end

  def fire(direction)
    x_speed = 0.0
    y_speed = 0.0

    x_speed += 1.0 if direction == :left
    x_speed -= 1.0 if direction == :right
    y_speed += 1.0 if direction == :down
    y_speed -= 1.0 if direction == :up

    Bullet.new(@window, x, y, x_speed, y_speed)
  end

  def update
    if move_up
      unless y <= 0
        @y += -@player_speed
      end
    end

    if move_down
      unless y >= 550
        @y += @player_speed
      end
    end

    if move_right
      unless x >= 750
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
