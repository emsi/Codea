-- Button and Block test suite

-- Use this function to perform your initial setup
function setup()
    
    --displayMode(FULLSCREEN)
    touches={}
    buttons={}
    
    -- create buttons and movable blocks
    table.insert(buttons,RectButton("Cargo Bot:Command Grab",100,120))
    table.insert(buttons,RectButton("Cargo Bot:Command Left",150,120))
    table.insert(buttons,RectButton("Cargo Bot:Command Grab",200,120))
    table.insert(buttons,RectButton("Cargo Bot:Command Left",250,120))
    
    table.insert(buttons,RectBlock("Cargo Bot:Crate Red 1",380,660))
    table.insert(buttons,RectBlock("Cargo Bot:Crate Red 1",480,560))
    
    table.insert(buttons,RectBlock("Cargo Bot:Crate Red 2",383,600))
    table.insert(buttons,RectBlock("Cargo Bot:Crate Red 2",480,460))
    
    table.insert(buttons,RectBlock("Cargo Bot:Title Large Crate 1",400,400))
    
    -- assign callback to first two buttons
    buttons[1].onTouchBegan=touchBegan;
    buttons[2].onTouchEnded=touchEnded;
    
    -- Create triangle sprite
    triangle = image (50*1.5,50*1.5)
    setContext(triangle)
    stroke(200,20,200)
    strokeWidth(3)
    line(2*1.5,3*1.5,48*1.5,3*1.5)
    line(2*1.5,3*1.5,25*1.5,47*1.5)
    line(48*1.5,3*1.5,25*1.5,47*1.5)
    setContext()
    
    -- Triangle button and block
    table.insert(buttons,TriangleBlock(triangle,100,400,0,0,50*1.5,0,25*1.5,50*1.5))
    table.insert(buttons,TriangleButton(triangle,310,120,0,0,50*1.5,0,25*1.5,50*1.5))
    buttons[#buttons].onTouchBegan=triangleTouchBegan


end

function touchBegan()
    print("touchBegan")
end

function touchEnded()
    print("touchEND")
end

function triangleTouchBegan()
    print("triangle")
end


-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(40, 40, 50)
    
    processTouches() -- process registered touches
    -- Draw buttons
    for k,b in pairs(buttons) do
        b:draw()
    end
    
end

function processTouches()
    for i,t in pairs(touches) do
        for l,b in pairs(buttons) do
                b:touched(t) -- call ghis method for every touch and every button combination
        end
        if t.state==ENDED then touches[t.id]=nil end -- remove the touch that has ended
    end
end


function touched(touch)
    touches[touch.id]=touch -- register all the touches to be processed 
end


