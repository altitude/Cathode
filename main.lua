function love.load()

	require("cathode")

	math.randomseed(os.time())

	window = {
		width = 850,
		height = 380
	}

	love.graphics.setMode(window.width,window.height)	

	space = {
		background = love.graphics.newCanvas(window.width/3+1, window.height/3),
		stars = love.graphics.newCanvas(window.width/3, window.height/3),
		text = love.graphics.newCanvas(window.width/3, window.height/3),
		font = love.graphics.newFont("Hardpixel.OTF",20),
		fancy = love.graphics.newCanvas(window.width/3, window.height/3),
		destroyed = love.graphics.newCanvas(window.width/3, window.height/3),
		bender = love.graphics.newImage("bender.png"),
	}

	love.graphics.setCanvas(space.background)
	love.graphics.setColor(24,18,89,255)
	love.graphics.rectangle("fill",0,0,window.width/3+1,window.height/3)
	love.graphics.setCanvas()

	love.graphics.setCanvas(space.stars)
	love.graphics.setColor(61,80,245,255)
	for i=1,600 do
		love.graphics.rectangle("fill",math.random(0,window.width/3),math.random(0,window.height/3),1,1)
	end
	love.graphics.setCanvas()

	love.graphics.setCanvas(space.fancy)
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(space.bender,0,-140)
	love.graphics.setCanvas()
	
	love.graphics.setCanvas(space.destroyed)
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(space.bender,0,-140)
	love.graphics.setCanvas()

	love.graphics.setCanvas(space.text)
	love.graphics.setColor(50,73,219,255)
	love.graphics.setFont(space.font)
	love.graphics.print("Cathode Lib 0.8",0,40)
	love.graphics.setCanvas()
	
	-- transform canvases into CRT canvases, 3 times bigger, using cathode function
	space.background = cathode(space.background,3)
	space.stars = cathode(space.stars,3)
	space.text = cathode(space.text,3)
	space.fancy = cathode(space.fancy,3)
	space.destroyed = cathode(space.destroyed,3,{0.1,10,0.01,0.992}) --This one has a modifier set, you can try to fiddle with values

	index = 0

end

function love.update(dt)
	love.timer.sleep(.01)
end

function love.keypressed(key)
	if key == "return" then
		if index < 2 then
			index = index+1
		else
			index = 0
		end
	end
end

function love.draw()
	
	love.graphics.setColor(255,255,255,255)
	love.graphics.clear()
	love.graphics.draw(space.background,0,0)
	love.graphics.draw(space.stars,0,0)
	if index == 1 then
		love.graphics.draw(space.fancy,0,0)
		love.graphics.draw(space.bender,42,200,0,0.42,0.42)
	elseif index == 2 then
		love.graphics.draw(space.destroyed,0,0)
	else
		love.graphics.draw(space.text,200,0)
		love.graphics.setFont(space.font)
		love.graphics.print("Press enter !",360,200)
	end

end
