class Enemy
  include BoundingBox

  attr_reader :x, :y

  def initialize(window, x, y, player)
    @enemy_image = Gosu::Image.new(window, 'img/circle_blue.png')
    @window = window
    @starting_x = x
    @starting_y = y
    @x = x
    @y = y

    @random_movement = (1..5).to_a
    @picked = @random_movement.sample
    @bounding = bounding(@x, @y, 48, 48)
    @bounce = false

    @player = player
  end

  def draw
    @enemy_image.draw(@x, @y, 1)
  end

  def update
    case
    when  @x >= 752 || @y >= 552
      @bounce = true
    when  @x <= 0 || @y <= 0
      @bounce = false
    end

    if @bounce == true
      # @picked = @random_movement.sample
      if @player.x < @x
        @p1 = @player
        @p2 = self
      else
        @p1 = @player
        @p2 = self
      end
      slope = calculate_slope(@p1, @p2)

       @x += -1
       @y += -slope
    else
      @x += @picked
      @y += -@picked
    end

    @bounding = bounding(@x, @y, 48, 48)
  end

  def calculate_slope(p1, p2)
    slope = (p2.y - p1.y)/(p2.x - p1.x)
  end


end
