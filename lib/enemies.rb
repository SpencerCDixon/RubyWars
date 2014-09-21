class Enemy

  attr_reader :x, :y, :player, :speed, :death
  attr_accessor :state

  def initialize(window, x, y, player)
    @enemy_image = Gosu::Image.new(window, 'img/spider.png')
    @player = player
    @window = window
    @x = x
    @y = y
    @state = :attack

    @speed = 4
    @bounce = false

    @death = Gosu::Sample.new(@window, 'music/Shot 4.wav')
  end

  def bounds
    BoundingBox.new(@x, @y, 50, 42)
  end

  def draw
    @enemy_image.draw(@x, @y, 1)
  end

  def update
    unless @state == :pause
      @bounce = true if  @x >= 752 || @y >= 552 || @x <= 0 || @y <= 0
      if @bounce == true

        dx = (player.x - self.x).to_f
        dy = (player.y - self.y).to_f

        distance = Math.sqrt((dx * dx) + (dy * dy))

        vel_x = (dx / distance) * speed
        vel_y = (dy / distance) * speed

        @x += vel_x
        @y += vel_y
      else
        @x += speed
        @y += -speed
      end
    end
  end

end
