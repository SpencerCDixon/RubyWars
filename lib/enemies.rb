class Enemy

  attr_reader :x, :y, :player, :speed

  def initialize(window, x, y, player)
    @enemy_image = Gosu::Image.new(window, 'img/circle_blue.png')
    @player = player
    @window = window
    @x = x
    @y = y

    @speed = 4
    @bounce = false
  end

  def bounds
    BoundingBox.new(@x, @y, 48, 48)
  end

  def draw
    @enemy_image.draw(@x, @y, 1)
  end

  def update
    @bounce = true if  @x >= 752 || @y >= 552 || @x <= 0 || @y <= 0

    if @bounce == true

      dx = (player.x - self.x).to_f
      dy = (player.y - self.y).to_f

      distance = Math.sqrt((dx * dx) + (dy * dy))

      vel_x = (dx / distance) * speed
      vel_y = (dy / distance) * speed

      @x += vel_x
      @y += vel_y
    else
      @x += speed
      @y += -speed
    end
  end

end
