module Motion
  class NumpadView < UIView
    attr_accessor :color, :delegate

    def self.numpadWithColor color, delegate: aDelegate
      self.alloc.initWithFrame(CGRectZero).tap { |v|
        color = color.to_s if color.kind_of? Symbol
        color_method = "#{color.downcase}Color"
        if UIColor.respond_to?(color_method)
          v.color = UIColor.send(color_method)
        else
          v.color = UIColor.whiteColor
        end
        v.backgroundColor = UIColor.clearColor
        v.delegate = aDelegate ? aDelegate : v

        v.create_buttons
      }
    end

    def drawRect rect
      @b9.addConstraint( 
        NSLayoutConstraint.constraintWithItem( @b9,
                                    attribute: NSLayoutAttributeHeight,
                                    relatedBy: NSLayoutRelationEqual,
                                       toItem: @b9,
                                    attribute: NSLayoutAttributeWidth,
                                   multiplier: 1,
                                     constant: 0 )
      )

      # Button sizes for iPad might more like to be 82 h/w. But I prefer to make it bigger in this occasion.
      btn_size = Device.ipad? ? '128@600' : '76@600' 

      Motion::Layout.new { |layout|
        layout.view self
        layout.subviews @buttons
        layout.metrics "hs" => 20, "vs" => 12.5

        layout.horizontal "|[b7(b9)]-hs-[b8(b9)]-hs-[b9(#{btn_size})]|"
        layout.horizontal "|[b4(b9)]-hs-[b5(b9)]-hs-[b6(b9)]|"
        layout.horizontal "|[b1(b9)]-hs-[b2(b9)]-hs-[b3(b9)]|"
        layout.horizontal "[b0(b9)]-hs-[b10(b9)]|"

        layout.vertical   "|[b9]-vs-[b6(b9)]-vs-[b3(b9)]-vs-[b10(b9)]|"
        layout.vertical   "|[b8(b9)]-vs-[b5(b9)]-vs-[b2(b9)]-vs-[b0(b9)]|"#, :center_x
        layout.vertical   "|[b7(b9)]-vs-[b4(b9)]-vs-[b1(b9)]"
      }
    end

    def create_buttons
      @buttons = {}

      (0..10).each { |num|
        NumericButton.new(num, color) { |numbtn|
          numbtn.set_targets delegate
          instance_variable_set "@b#{num}", numbtn
          @buttons[:"b#{num}"] = numbtn
        }
      }

      @b10.tap { |btn|
        btn.setTitle 'Clear', forState: UIControlStateNormal
        btn.titleLabel.font = btn.titleLabel.font.fontWithSize 24
        btn.setTitleColor UIColor.grayColor, forState: UIControlStateNormal
        btn.layer.borderWidth = 0
      }
    end

    def numbutton_touch_down sender
      if sender.currentTitle =~ /\d/
        UIView.animateWithDuration( 0.1,
                        animations: ->{ sender.layer.backgroundColor = @color.colorWithAlphaComponent(0.7).CGColor },
                        completion: nil )
      end
    end

    def numbutton_touch_up sender
      p sender.tag
      UIView.animateWithDuration( 0.3,
                           delay: 0.2,
                         options: UIViewAnimationCurveEaseIn,
                      animations: ->{ sender.layer.backgroundColor = UIColor.clearColor.CGColor },
                      completion: nil )

    end

    def buttons_prepared_for_appear
      if @buttons
        @buttons.each { |key, button| 
          unless key == :b10
            UIView.animateWithDuration( 0.1,
                            animations: ->{ button.layer.opacity = 0.5 },
                            completion: ->(finished){ button.layer.cornerRadius = button.bounds.size.width / 2 } )
          end
        }
      end
    end

    def make_buttons_appeared
      @buttons.each { |key, button| 
        unless key == :b10
          UIView.animateWithDuration( 0.1,
                          animations: ->{ button.layer.opacity = 1.0 },
                          completion: nil)
        end
        }
    end
  end
end
