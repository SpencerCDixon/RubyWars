module Keys

  def button_down(id)
    if @state != :lose
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
    end
    # Menu
    if id == Gosu::KbUp
      @menu.selection -= 1
      @menu.select_sound.play(0.4) if @sfx == true
      if @menu.selection < 1
        @menu.selection = 3
      end
    elsif id == Gosu::KbDown
      @menu.selection += 1
      @menu.select_sound.play(0.4) if @sfx == true
      if @menu.selection > 3
        @menu.selection = 1
      end
    elsif id == Gosu::KbReturn
      if @menu.selection == 1
        @menu.menu_action = "start"
        @background.theme.play
      elsif @menu.selection == 2
        @menu.menu_action = "mtoggle"
      elsif @menu.selection == 3
        @menu.menu_action = "sfxtoggle"
      end
    end

    if @state == :lose
      if id == Gosu::KbR
        reset(:menu)
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
