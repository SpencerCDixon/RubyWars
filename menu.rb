class Menu
  attr_accessor :selection, :music, :sfx, :menu_action, :select_sound

  def initialize(window, x, y, music, sfx)
    @window = window
    @y = y
    @x = x
    @music = music
    @sfx = sfx

    # Assets
    @menu_font = Gosu::Font.new(@window, "Futura", 600 / 15)
    @control_font = Gosu::Font.new(@window, "Futura", 600 / 30)
    @select_sound = Gosu::Sample.new(@window, 'music/menuselect.ogg')
    @bg_image = Gosu::Image.new(window, 'img/menu/menu_background.png')
    @title = Gosu::Image.new(window, 'img/title.png')

    # Logic
    @selection = 1
    @menu_action = nil
  end

  def draw
    @bg_image.draw(@x, @y, 0)
    @title.draw(150, 100, 0)

    # Toggle Music/SFX
    @window.music == true ? @music_value = "ON" : @music_value = "OFF"
    @window.sfx == true ? @sfx_value = "ON" : @sfx_value = "OFF"

    # Menu Controls
    scolor, mcolor, fcolor = 0xffffffff, 0xffffffff, 0xffffffff
    hcolor = Gosu::Color::RED

    scolor = hcolor if @selection == 1
    draw_text_centered("Play Game", @menu_font, 75, scolor)
    mcolor = hcolor if @selection == 2
    draw_text_centered("Music: #{@music_value} ", @menu_font, 120, mcolor)
    fcolor = hcolor if @selection == 3
    draw_text_centered("SFX: #{@sfx_value} ", @menu_font, 165, fcolor)
    draw_text(620, 5, "Playing As: #{@window.name}", @control_font, 0xffffd700)

    # Player Controls
    draw_text(15, 465, "Controls:", @control_font, 0xffffffff)
    draw_text(15, 485, "R - Reset at gameover", @control_font, 0xffffffff)
    draw_text(15, 505, "A/W/S/D - Move Player", @control_font, 0xffffffff)
    draw_text(15, 525, "J/I/K/L - Shoot", @control_font, 0xffffffff)
    draw_text(15, 545, "Spacebar - Use Help Request", @control_font, 0xffffffff)
    draw_text(15, 565, "P - Activate Pry", @control_font, 0xffffffff)

    # Credits
    draw_text(595, 545, "Created by Spencer Dixon ", @control_font, 0xffffffff )
    draw_text(595, 565, "github.com/SpencerCDixon", @control_font, 0xffffffff )
  end

  def update
    @menu_action
  end

  def draw_text_centered(text, font, y_adjust, c)
    x = (800 - font.text_width(text)) / 2
    y = (600 - font.height) / 2
    y += y_adjust
    color = c
    draw_text(x, y, text, font, color)
  end

  def draw_text(x, y, text, font, color)
    font.draw(text, x, y, 3, 1, 1, color)
  end


end
