class Enemy

  attr_reader :x, :y

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

      calculate_slope(@player, self)

       @x += -(@slope_x / 60.0)
       @y += -(@slope_y / 60.0)
    else
      @x += @picked
      @y += -@picked
    end


  end

  def calculate_slope(p1, p2)
    @slope_y = (p2.y - p1.y)
    @slope_x = (p2.x - p1.x)
  end

  def bounds
    BoundingBox.new(@x, @y, 48, 48)
  end


end
