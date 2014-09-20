class Menu
  attr_accessor :selection, :music, :sfx, :menu_action

  def initialize(window, x, y, music, sfx)
    @window = window
    @y = y
    @x = x
    @bg_image = Gosu::Image.new(window, 'img/menu/menu_background.png')
    @music = music
    @sfx = sfx

    # Fonts
    @menu_font = Gosu::Font.new(@window, "Futura", 600 / 15)

    # Logic
    @selection = 1
    @menu_action = nil
  end

  def draw
    @bg_image.draw(@x, @y, 0)

    music == true ? @music_value = "ON" : @music_value = "OFF"
    sfx == true ? @sfx_value = "ON" : @sfx_value = "OFF"

    scolor, mcolor, fcolor = 0xffc0c0c0, 0xffc0c0c0, 0xffc0c0c0
    hcolor = 0xffffd700

    scolor = hcolor if @selection == 1
    @menu_font.draw("Play Game", 300, 350, 3, 1, 1, scolor)
    mcolor = hcolor if @selection == 2
    @menu_font.draw("Music: #{@music_value} ", 300, 400, 3, 1, 1, mcolor)
    fcolor = hcolor if @selection == 3
    @menu_font.draw("SFX: #{@sfx_value}", 300, 450, 3, 1, 1, fcolor)

  end

  def update
    @menu_action
  end

  def draw_text_centered(text, font)
    x = (800 - font.text_width(text)) / 2
    y = (600 - font.height) / 2
    color = Gosu::Color::RED
    draw_text(x, y, text, font, color)
  end

  def draw_text(x, y, text, font, color)
    font.draw(text, x, y, 3, 1, 1, color)
  end


end
