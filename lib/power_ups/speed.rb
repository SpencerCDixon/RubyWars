class SpeedBoost

  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y

    @speed_boost_image = Gosu::Image.new(window, 'img/rails.jpg')
  end

  def bounds
    BoundingBox.new(@x, @y, 64, 64)
  end

  def draw
    @speed_boost_image.draw(@x, @y, 0)
  end

  def boost
    @window.player.player_speed += 3
  end

end
