class Background
  def initialize(window, x, y)
    @window = window
    @y = y
    @x = x
    @bg_image = Gosu::Image.new(window, 'img/Space-Background.jpg')
  end

  def draw
    @bg_image.draw(@x, @y, 0)
  end
end
