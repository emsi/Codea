-- Rectangular button class

RectButton = class()

function RectButton:onTouchBegan(t) end -- user defined
function RectButton:onTouchEnded(t) end -- user defined
function RectButton:onTouchMoving(t) end -- user defined
function RectButton:onTouch(t) end -- user defined

function RectButton:init(sprite, x, y)
    self.x, self.y, self.sprite=x, y, sprite 
    self.w, self.h = spriteSize(sprite) -- memorize original size
    self.size=self.w -- setu button side to its width
    self.activeTouch=nil -- if the button is touch this variable holds the touch id
    self.touchCoef=1.2
end

function RectButton:draw()
    sprite(self.sprite,self.x,self.y,self.size)  -- draw sprite
end

function RectButton:touched(touch)
    self.onTouch() -- process callback
    if not self.activeTouch then -- the button was not touched
        if touch.state==BEGAN and self:hit(vec2(touch.x,touch.y)) then -- new touch began
            self.activeTouch=touch.id -- remember the touch id
            self.size=self.w*self.touchCoef -- enlarge the button
            self.onTouchBegan(touch) -- process callback
        end
    elseif self.activeTouch==touch.id then -- the button was touched
        if touch.state==ENDED then -- the touch ended
            self.size=self.w -- restore normal button size
            self.activeTouch=nil -- clear the remembered touch
            self.onTouchEnded(touch) -- callback
        end
    end
end

function RectButton:hit(point) -- returns true if the points is within button rectangle
    if math.abs(point.x-self.x)<=self.w/2
        and math.abs(point.y-self.y)<=self.h/2 then 
        return true
    end        
    return false
end