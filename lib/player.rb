class Player
  include BoundingBox
  attr_accessor :x, :y, :move_up, :move_down, :move_right, :move_left

  def initialize(window, x, y)
    @player_image = Gosu::Image.new(window, 'img/ruby.jpg')
    @x = x
    @y = y

    @move_up = false
    @move_down = false
    @move_right = false
    @move_left = false

    @bounding = bounding(@x, @y, 29, 29)

  end

  def draw
    @player_image.draw(@x, @y, 1)
  end

  def update
    if move_up then @y += -7 end
    if move_down then @y += 7 end
    if move_right then @x += 7 end
    if move_left then @x += -7 end
    @bounding = bounding(@x, @y, 29, 29)
  end

end
