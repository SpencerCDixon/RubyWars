class BombBoost
attr_reader :name
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @state = :unused
    @ee_image = ["eric", "adam", "helen", "richard", "faizaan"].sample
    @bomb_image = Gosu::Image.new(window, "img/#{@ee_image}.png")
    @name = "Bomb boost"
  end

  def bounds
    BoundingBox.new(@x, @y, 100, 100)
  end

  def draw
    if unused?
      @bomb_image.draw(@x, @y, 0)
    end
  end

  def boost(player)
    player.bombs += 1
    use
  end

  def use
    @state = :used
  end

  def unused?
    @state == :unused
  end

end
