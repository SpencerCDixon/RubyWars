class SpeedBoost
attr_reader :name
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @state = :unused
    @name = "speed boost"

    @speed_boost_image = Gosu::Image.new(window, 'img/rails.jpg')
  end

  def bounds
    BoundingBox.new(@x, @y, 64, 64)
  end

  def draw
    if unused?
      @speed_boost_image.draw(@x, @y, 0)
    end
  end

  def boost(player)
    player.player_speed += 2
    use
  end

  def use
    @state = :used
  end

  def unused?
    @state == :unused
  end

end