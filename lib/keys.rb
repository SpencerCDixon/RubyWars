module Keys
  def button_down(id)
    if id == Gosu::KbW
      @player.move_up = true
    end

    if id == Gosu::KbS
      @player.move_down = true
    end

    if id == Gosu::KbA
      @player.move_left = true
    end

    if id == Gosu::KbD
      @player.move_right = true
    end
  end

  def button_up(id)
    if id == Gosu::KbW
      @player.move_up = false
    end

    if id == Gosu::KbS
      @player.move_down = false
    end

    if id == Gosu::KbA
      @player.move_left = false
    end

    if id == Gosu::KbD
      @player.move_right = false
    end
  end
end
