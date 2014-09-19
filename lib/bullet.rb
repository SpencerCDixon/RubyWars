class Bullet

  def initialize(window, x, y, x_speed, y_speed)
    @window = window
    @x = x
    @y = y
    @x_speed = x_speed
    @y_speed = y_speed
    @bullet_image = Gosu::Image.new(window, 'img/ruby_shard.png')

  end

  def bounds
    BoundingBox.new(@x, @y, 9, 9)
  end

  def draw
    @bullet_image.draw(@x, @y, 1)
  end

  def update
    @x += 10 * @x_speed
    @y += 10 * @y_speed
  end

end
