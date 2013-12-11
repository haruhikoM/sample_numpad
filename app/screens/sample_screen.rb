class SampleScreen < PM::Screen
  def on_load
    view.backgroundColor = UIColor.darkGrayColor
  end

  def will_appear
    @loaded_views ||= begin
      @numpad = Motion::NumpadView.numpadWithColor :green, delegate: nil

      Motion::Layout.new { |layout|
        layout.view view
        layout.subviews numpad: @numpad
        layout.metrics  offset: 38
        layout.vertical   "|-(>=offset)-[numpad(>=150)]-(>=offset)-|"
        layout.horizontal "[numpad(>=120)]"
      }

      view.addConstraints([
         NSLayoutConstraint.constraintWithItem( @numpad,
                                     attribute: NSLayoutAttributeCenterX,
                                     relatedBy: NSLayoutRelationEqual,
                                        toItem: view,
                                     attribute: NSLayoutAttributeCenterX,
                                    multiplier: 1,
                                      constant: 0 ),

         NSLayoutConstraint.constraintWithItem( @numpad,
                                     attribute: NSLayoutAttributeCenterY,
                                     relatedBy: NSLayoutRelationEqual,
                                        toItem: view,
                                     attribute: NSLayoutAttributeCenterY,
                                    multiplier: 1,
                                      constant: 0 )
      ])
      true
    end
    @numpad.alpha = 0
    @numpad.buttons_prepared_for_appear
    @numpad.layoutSubviews
  end


  def on_appear
    @numpad.make_buttons_appeared
    UIView.animateWithDuration( 0.1,
                    animations: ->{ @numpad.alpha = 1 },
                    completion: nil )
  end

  def will_rotate ori, dur
    @numpad.buttons_prepared_for_appear
  end

  def on_rotate
    @numpad.make_buttons_appeared
  end
end
