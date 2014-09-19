class Enemy
  SPEED = 4
  attr_reader :x, :y, :player

  def initialize(window, x, y, player)
    @enemy_image = Gosu::Image.new(window, 'img/circle_blue.png')
    @window = window
    @starting_x = x
    @starting_y = y
    @x = x
    @y = y


    @random_movement = (1..3).to_a
    @picked = @random_movement.sample
    # @bounding = Bounding.new(@x, @y, 48, 48)
    @bounce = false

    @player = player
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

      vel_x = (dx / distance) * SPEED
      vel_y = (dy / distance) * SPEED

      @x += vel_x
      @y += vel_y
    else
      @x += @picked
      @y += -@picked
    end


  end

  def length_squared
    (@player.x * @player.x) + (@player.y * @player.y)
  end

  def length
    Math.sqrt(length_squared)
  end

  def normalize
    @vx = @player.x / length
    @vy = @player.y / length
  end

  def calculate_slope(p1, p2)
    @slope_y = (p2.y - p1.y)
    @slope_x = (p2.x - p1.x)
  end

  def bounds
    BoundingBox.new(@x, @y, 48, 48)
  end


end
