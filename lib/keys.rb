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
    if id == Gosu::KbSpace
      if @player.bombs >= 1
        @player.bombs -= 1
        @enemies.clear
      end
    end

    # Bullets
    case
    when id == Gosu::KbI
      @bullets << @player.fire(:up)
    when id == Gosu::KbK
      @bullets << @player.fire(:down)
    when id == Gosu::KbL
      @bullets << @player.fire(:left)
    when id == Gosu::KbJ
      @bullets << @player.fire(:right)
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
