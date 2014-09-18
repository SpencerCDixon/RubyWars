class Enemy
  include BoundingBox

  attr_reader :x, :y

  def initialize(window, x, y)
    @enemy_image = Gosu::Image.new(window, 'img/circle_blue.png')
    @window = window
    @x = x
    @y = y
    @random_movement = (1..5).to_a
    @picked = @random_movement.sample
    @bounding = bounding(@x, @y, 48, 48)
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

    @bounding = bounding(@x, @y, 48, 48)
  end


end
