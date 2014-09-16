class Enemy
  include BoundingBox
  # attr_accessor :random_movement

  def initialize(window, x, y)
    @enemy_image = Gosu::Image.new(window, 'img/circle_blue.png')
    @x = x
    @y = y
    @random_movement = (1..10).to_a
    @picked = @random_movement.sample
    # generate_random_points
    bounding(@x, @y, 48, 48)
    @bounce = false
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
      @picked = @random_movement.sample
      @x += -@picked
      @y += -@picked
    else


      @x += @picked
      @y += @picked
    end
    #
    # if @bounce == true
    #   if @x >= 752
    #     @bounce = true
    #     @x += -3
    #
    #     @x +=   3
    #   end
    #
    #
    #
    #   if @y >= 552
    #     @bounce = true
    #     @y += -3
    #   elsif @bounce == false
    #     @y += 3
    #   end

    bounding(@x, @y, 48, 48)

  end

end
