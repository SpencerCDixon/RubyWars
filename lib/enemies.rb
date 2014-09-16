class Enemy
  # include BoundingBox
  # attr_accessor :random_movement

  def initialize(window, x, y)
    @enemy_image = Gosu::Image.new(window, 'img/circle_blue.png')
    @x = x
    @y = y
    @random_movement = []
    # generate_random_points
    # bounding(@x, @y, 48, 48)
  end


  def draw
    @enemy_image.draw(@x, @y, 1)
  end

  def update
    @x += rand(10)
    @y += rand(10)
    # bounding(@x, @y, 48, 48)
  end

end
