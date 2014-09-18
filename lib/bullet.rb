class Bullet
  include BoundingBox

  def initialize(window, x, y, x_speed, y_speed)
    @window = window
    @x = x
    @y = y
    @x_speed = x_speed
    @y_speed = y_speed
    @bullet_image = Gosu::Image.new(window, 'img/laser.png')
    @speed = 1
    @direction = #figure out

    @bounding = bounding(@x, @y, 64, 64)
  end

  def draw
    @bullet_image.draw(@x, @y, 1)
  end

  def update
    @x += 10 * @x_speed
    @y += 10 * @y_speed
    @bounding = bounding(@x, @y, 64, 64)
  end

end
