module Motion
  class NumericButton < UIButton
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
        #btn.titleLabel.font = UIFont.preferredFontForTextStyle UIFontTextStyleBody
        btn.titleLabel.adjustsFontSizeToFitWidth = true
        btn.titleLabel.minimumFontSize = 12
        block.call btn
      end
    end

    def set_targets target
      self.addTarget target, action: 'numbutton_touch_up:'  , forControlEvents: UIControlEventTouchUpInside
      self.addTarget target, action: 'numbutton_touch_down:', forControlEvents: UIControlEventTouchDown
    end

    private

    def font_size
      Device.ipad? ? 42 : 30
    end
  end
end
