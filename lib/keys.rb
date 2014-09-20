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
    if id == Gosu::KbP
      if @player.binding_pry >= 1
        @player.binding_pry -= 1
        if @timer.seconds < (@timer.seconds + 3)
          @enemies.each {|e| e.state = :pause}
        else
          @enemies.each {|e| e.state = :attack}
        end
      end
    end

    # Bullets
    case
    when id == Gosu::KbI
      if @player.bullet_speed_boost > 0
        @bullets << @player.fire(:up, @player.bullet_speed_boost)
      else
         @bullets << @player.fire(:up)
      end
    when id == Gosu::KbK
      if @player.bullet_speed_boost > 0
        @bullets << @player.fire(:down, @player.bullet_speed_boost)
      else
        @bullets << @player.fire(:down)
      end
    when id == Gosu::KbL
      if @player.bullet_speed_boost > 0
         @bullets << @player.fire(:left, @player.bullet_speed_boost)
      else
        @bullets << @player.fire(:left)
      end
    when id == Gosu::KbJ
      if @player.bullet_speed_boost > 0
        @bullets << @player.fire(:right, @player.bullet_speed_boost)
      else
        @bullets << @player.fire(:right)
      end
    end

    # Menu
    if id == Gosu::KbUp
      @menu.selection -= 1
      if @menu.selection < 1
        @menu.selection = 3
      end
    elsif id == Gosu::KbDown
      @menu.selection += 1
      if @menu.selection > 3
        @menu.selection = 1
      end
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
