class Bullet

  def initialize(window, x, y, x_speed, y_speed, direction)
    @window = window
    @x = x
    @y = y
    @x_speed = x_speed
    @y_speed = y_speed
    @bullet_image = Gosu::Image.new(window, 'img/ruby_shard.png')
    @direction = direction.first.to_s

    @speed = 1

  end
  def bounds
    BoundingBox.new(@x, @y, 9, 9)
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
  end

end
