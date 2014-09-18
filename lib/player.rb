class Player
  include BoundingBox
  attr_accessor :x, :y, :direction
  attr_reader :move_up, :move_down, :move_right, :move_left

  def initialize(window, x, y)
    @player_image = Gosu::Image.new(window, 'img/ruby.jpg')
    @x = x
    @y = y

    @move_up = false
    @move_down = false
    @move_right = false
    @move_left = false
    @direction = :right

    @bounding = bounding(@x, @y, 29, 29)
    @window = window
  end

  def move_left=(value)
    @move_left = value
    @direction = :left if value
  end

  def move_right=(value)
    @move_right = value
    @direction = :right if value
  end

  def move_up=(value)
    @move_up = value
    @direction = :up if value
  end

  def move_down=(value)
    @move_down = value
    @direction = :down if value
  end

  def fire
    x_speed = 0.0
    y_speed = 0.0

    # if @direction.include?(:right) && @direction.include?(:up)
    #   x_speed = 0.6
    #   y_speed = -0.6
    # elsif @direction.include?(:up)
    #   y_speed = -1.0
    case @direction
    when :up
      y_speed = -1.0
    when :down
      y_speed = 1.0
    when :right
      x_speed = 1.0
    when :left
      x_speed = -1.0
    end

    Bullet.new(@window, x, y, x_speed, y_speed)
  end

  def draw
    @player_image.draw(@x, @y, 1)
  end

  def update
    if move_up then @y += -7 end
    if move_down then @y += 7 end
    if move_right then @x += 7 end
    if move_left then @x += -7 end
    @bounding = bounding(@x, @y, 29, 29)
  end

end
