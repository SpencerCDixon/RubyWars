class Background
  attr_reader :theme, :menu_music
  def initialize(window, x, y)
    @window = window
    @y = y
    @x = x
    @bg_image1 = Gosu::Image.new(window, 'img/backgrounds/bg1.png')
    @bg_image2 = Gosu::Image.new(window, 'img/backgrounds/bg2.png')
    @bg_image3 = Gosu::Image.new(window, 'img/backgrounds/bg3.png')
    @bg_image4 = Gosu::Image.new(window, 'img/backgrounds/bg4.png')
    @bg_image5 = Gosu::Image.new(window, 'img/backgrounds/bg5.png')
    @bg_image6 = Gosu::Image.new(window, 'img/backgrounds/bg6.png')

    @song_path = ['music/cherry.mp3', 'music/Awake.mp3', 'music/L.mp3'].sample
    @theme = Gosu::Song.new(window, @song_path)
    @menu_music = Gosu::Song.new(window, 'music/menu.mp3')
  end

  def draw
    case
    when @window.score >= 100_000
      @bg_image6.draw(@x, @y, 0)
    when @window.score >= 80_000
      @bg_image5.draw(@x, @y, 0)
    when @window.score >= 40_000
      @bg_image4.draw(@x, @y, 0)
    when @window.score >= 20_000
      @bg_image3.draw(@x, @y, 0)
    when @window.score >= 10_000
      @bg_image2.draw(@x, @y, 0)
    else
      @bg_image1.draw(@x, @y, 0)
    end
  end
end
