Create Numpad with iOS Auto Layout.
=============

Sample App for Demonstrating NumpadView which is built with Basic Auto Layout Funcionality
The article' link which described this app more will be posted here onece it's appeared! 
[Here we go! (Although it is written in Japanese.)](http://qiita.com/OkonomiyakiYuki/items/d6f12d092837efc8c755)

clone it

`git clone https://github.com/haruhikoM/sample_numpad.git`

bundle it

`bundle install`

and rake!

`rake`

If you want to see what it looks like on iPad, then

`rake simulator device_family=ipad`

##Usage##

This App only shows how to constract the iOS's passcode-lock-screen-esque numeric keypad so that it does not do any useful things(it's up to you to do the trick!).

initialize
`@numpad = Motion::NumpadView.numpadWithColor :green, delegate: nil`
 
When numeric buttons are tapped, those two methods are triggered. In most cases you wanted to do something great inside #numbutton_touch_up: .

```ruby
def numbutton_touch_down sender
end

def numbutton_touch_up sender
end
```

##License##
MIT.
