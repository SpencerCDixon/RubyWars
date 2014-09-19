require "set"

class Player
  attr_accessor :x, :y, :direction
  attr_reader :move_up, :move_down, :move_right, :move_left, :bounds

  def initialize(window, x, y)
    @player_image = Gosu::Image.new(window, 'img/ruby.jpg')
    @window = window
    @x = x
    @y = y

    @bullet_speed = 7

    @move_up = false
    @move_down = false
    @move_right = false
    @move_left = false
    @direction = Set.new([])


  end

  def move_left=(value)
    @move_left = value
    if value
      @direction.add(:left)
      @direction.delete(:right)
      @direction.delete(:up)
      @direction.delete(:down)
    end
  end

  def move_right=(value)
    @move_right = value
    if value
      @direction.add(:right)
      @direction.delete(:left)
      @direction.delete(:up)
      @direction.delete(:down)
    end

  end

  def move_up=(value)
    @move_up = value
    if value
      @direction.add(:up)
      @direction.delete(:down)
      @direction.delete(:right)
      @direction.delete(:left)
    end
  end

  def move_down=(value)
    @move_down = value
    if value
      @direction.add(:down)
      @direction.delete(:up)
      @direction.delete(:right)
      @direction.delete(:left)
    end
  end

  def fire
    x_speed = 0.0
    y_speed = 0.0

    x_speed += 1.0 if @direction.include?(:right)
    x_speed -= 1.0 if @direction.include?(:left)
    y_speed += 1.0 if @direction.include?(:down)
    y_speed -= 1.0 if @direction.include?(:up)

    Bullet.new(@window, x, y, x_speed, y_speed, @direction)
  end

  def draw
    @player_image.draw(@x, @y, 1)
  end

  def update
    # unless @y >= 590 || @y <= 10
      if move_up then @y += -@bullet_speed end
      if move_down then @y += @bullet_speed end
    # end
    # unless @x >= 790 || @x <= 10
      if move_right then @x += @bullet_speed end
      if move_left then @x += -@bullet_speed end
    # end
  end

  def bounds
    BoundingBox.new(@x, @y, 29, 29)
  end

end
