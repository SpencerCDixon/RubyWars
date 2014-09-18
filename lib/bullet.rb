class Bullet
  include BoundingBox

  def initialize(window, x, y, x_speed, y_speed, direction)
    @window = window
    @x = x
    @y = y
    @x_speed = x_speed
    @y_speed = y_speed
    @bullet_image = Gosu::Image.new(window, 'img/laser.png')
    @direction = direction.first.to_s

    @speed = 1

    @bounding = bounding(@x, @y, 64, 64)
  end

  def draw
    if @direction == "right" || @direction == "left"
      @bullet_image.draw(@x, @y, 1)
    else
      @bullet_image.draw_rot(@x, @y, 1, 90)
    end
  end

  def update
    @x += 10 * @x_speed
    @y += 10 * @y_speed
    @bounding = bounding(@x, @y, 64, 64)
  end

end
