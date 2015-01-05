-- Basically a movable rectangular button

RectBlock = class(RectButton)

function RectBlock:touched(touch)
    self.onTouch(self, touch) -- process callback
    if not self.activeTouch then -- block was not touched
        if touch.state==BEGAN and self:hit(vec2(touch.x,touch.y)) then -- new touch began
            self.activeTouch=touch.id -- remember the touch id
            self.size=self.w*self.touchCoef -- enlarge the block
            self.dx=self.x-touch.x -- remember the touch offset
            self.dy=self.y-touch.y
            self.onTouchBegan(self, touch) -- process callback
        end
    elseif self.activeTouch==touch.id then -- the block was touched
        if touch.state==MOVING then -- the touch is moving
            self.x = touch.x + self.dx -- move the block respectively to thr touch
            self.y = touch.y + self.dy
            self.onTouchMoving(self, touch)
       elseif touch.state==ENDED then -- the touch ended
            self.size=self.w -- restore normal block size
            self.activeTouch=nil --clear the remembered touch
            self.onTouchEnded(self, touch) -- process callback
        end 
    end
end
