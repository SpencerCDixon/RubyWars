class Menu
  attr_accessor :selection

  def initialize(window, x, y)
    @window = window
    @y = y
    @x = x
    @bg_image = Gosu::Image.new(window, 'img/menu/menu_background.png')

    # Fonts
    @menu_font = Gosu::Font.new(@window, "Tahoma", 400 / 12)

    # Logic
    @selection = 1
  end

  def draw
    @bg_image.draw(@x, @y, 0)

    scolor, mcolor, fcolor = 0xffc0c0c0, 0xffc0c0c0, 0xffc0c0c0
    hcolor = 0xffffd700

    scolor = hcolor if @selection == 1
    @menu_font.draw("START GAME!", 200, 300, 3, 1, 1, scolor)
    mcolor = hcolor if @selection == 2
    @menu_font.draw("Music: ", 200, 400, 3, 1, 1, mcolor)
    @menu_font.draw("SFX: ", 200, 500, 3, 1, 1, fcolor)

  end

  def update
  end


end
