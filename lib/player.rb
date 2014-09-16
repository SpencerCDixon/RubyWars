class Player
  include BoundingBox
  attr_accessor :x, :y, :up, :down, :right, :left

  def initialize(window, x, y)
    @player_image = Gosu::Image.new(window, 'img/ruby.jpg')
    @x = x
    @y = y
    bounding(@x, @y, 29, 29)

    @up = false
    @down = false
    @right = false
    @left = false

  end

  def draw
    @player_image.draw(@x, @y, 1)
  end

  def update
    up ? @y += -7 : @y
    down ? @y += 7 : @y
    right ? @x += 7 : @x
    left ? @x += -7 : @x
    bounding(@x, @y, 29, 29)
  end

end
