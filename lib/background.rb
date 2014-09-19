class Background
  def initialize(window, x, y)
    @window = window
    @y = y
    @x = x
    @bg_image = Gosu::Image.new(window, 'img/bg.png')
  end

  def draw
    @bg_image.draw(@x, @y, 0)
  end
end
