class Bullet
  include BoundingBox

  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @bullet_image = Gosu::Image.new(window, 'img/laser.png')
    @velocity = 1

    @bounding = bounding(@x, @y, 64, 64)
  end

  def draw
    @bullet_image.draw(@x, @y, 1)
  end

  def update
    @x += 10 * @velocity
    @bounding = bounding(@x, @y, 64, 64)
  end

end
