module Keys
  def button_down(id)
    if id == Gosu::KbW
      @player.up = true
    end

    if id == Gosu::KbS
      @player.down = true
    end

    if id == Gosu::KbA
      @player.left = true
    end

    if id == Gosu::KbD
      @player.right = true
    end
  end

  def button_up(id)
    if id == Gosu::KbW
      @player.up = false
    end

    if id == Gosu::KbS
      @player.down = false
    end

    if id == Gosu::KbA
      @player.left = false
    end

    if id == Gosu::KbD
      @player.right = false
    end
  end
end
