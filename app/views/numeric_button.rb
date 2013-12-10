module Motion
  class NumericButton < UIButton
    attr_accessor :color, :target

    def initialize(num, color, &block)
      NumericButton.buttonWithType(UIButtonTypeCustom).tap do |btn|
        btn.tag = num
        btn.setTitle "#{num}", forState:UIControlStateNormal
        btn.setTitleColor color, forState: UIControlStateNormal
        btn.layer.borderWidth = 1
        btn.layer.borderColor = color.CGColor
        btn.layer.masksToBounds = true
        btn.titleLabel.textAlignment = NSTextAlignmentCenter
        btn.titleLabel.font = UIFont.fontWithName('HelveticaNeue-Light', size: font_size)
        btn.titleLabel.adjustsFontSizeToFitWidth = true
        btn.titleLabel.minimumFontSize = 12
        btn.color = color
        block.call btn
      end
    end

    def set_targets target
      self.addTarget self, action: 'numbutton_touch_up:'  , forControlEvents: UIControlEventTouchUpInside
      self.addTarget self, action: 'numbutton_touch_down:', forControlEvents: UIControlEventTouchDown

      @target = target
    end

    def numbutton_touch_down sender
      if sender.currentTitle =~ /\d/
        UIView.animateWithDuration( 0.1,
                        animations: ->{ sender.layer.backgroundColor = @color.colorWithAlphaComponent(0.7).CGColor },
                        completion: nil )
      end

      @target.numbutton_touch_down sender unless target == self
    end

    def numbutton_touch_up sender
      UIView.animateWithDuration( 0.3,
                           delay: 0.2,
                         options: UIViewAnimationCurveEaseIn,
                      animations: ->{ sender.layer.backgroundColor = UIColor.clearColor.CGColor },
                      completion: nil )

      @target.numbutton_touch_up sender unless target == self
    end

    private

    def font_size
      Device.ipad? ? 42 : 30
    end
  end
end
