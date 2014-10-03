-- Basically a triangle button

TriangleButton = class(RectButton)

-- Initialize a triangle button that will be drawn at x,y
-- ax,ay, bx,by, cx,cy  define triangle corners within the sprite
function TriangleButton:init(sprite, x, y, ax,ay, bx,by, cx,cy)
    self.x, self.y, self.sprite=x, y, sprite 
    self.w, self.h = spriteSize(sprite) -- memorize original size
    self.size=self.w -- setu button side to its width
    self.activeTouch=nil -- if the button is touch this variable holds the touch id
    self.touchCoef=1.2
    self.ax,self.bx,self.cx,self.ay,self.by,self.cy = ax,bx,cx,ay,by,cy
    parameter.watch (self.cx)
end

function TriangleButton:hit(point) -- returns true if the points is within button triangle
    -- Compute vectors
    v0 = vec2(self.cx-self.ax,self.cy-self.ay)
    v1 = vec2(self.bx-self.ax,self.by-self.ay)
    v2 = vec2(point.x-self.x-self.ax+self.w/2,point.y-self.y-self.ay+self.h/2)
    
    -- Compute dot products
    dot00 = v0:dot(v0)
    dot01 = v0:dot(v1)
    dot02 = v0:dot(v2)
    dot11 = v1:dot(v1)
    dot12 = v1:dot(v2)
    
    -- Compute barycentric coordinates
    invDenom = 1 / (dot00 * dot11 - dot01 * dot01)
    u = (dot11 * dot02 - dot01 * dot12) * invDenom
    v = (dot00 * dot12 - dot01 * dot02) * invDenom

    -- Check if point is in triangle
    return (u >= 0) and (v >= 0) and (u + v < 1)
end
