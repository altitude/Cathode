--Copyright (c) 2012 Clément Salaün

--This software is provided 'as-is', without any express or implied warranty.
--In no event will the authors be held liable for any damages arising from
--the use of this software.

--Permission is granted to anyone to use this software for any purpose, including
--commercial applications, and to alter it and redistribute it freely, subject
--to the following restrictions:

--1. The origin of this software must not be misrepresented; you must not claim
   --that you wrote the original software. If you use this software in a product,
   --an acknowledgment in the product documentation would be appreciated but is
   --not required.

--2. Altered source versions must be plainly marked as such, and must not be
   --misrepresented as being the original software.

--3. This notice may not be removed or altered from any source distribution.

--http://www.opensource.org/licenses/zlib-license.php

function cathode(canvas,unit,modifier)

	local modifier = modifier or {0,0,0,0}
	if #modifier < 4 then
		if #modifier == 1 then
			modifier = {modifier[1],10,0,0}
		elseif #modifier == 2 then
			modifier = {modifier[1],modifier[2],0,0}
		elseif #modifier ==3 then
			modifier = {modifier[1],modifier[2],modifier[3],0}
		end
	end

	local width = canvas:getWidth()
	local height = canvas:getHeight()
	local cathode = love.graphics.newCanvas(width*unit,height*unit)
	local actual_canvas = love.graphics.getCanvas()
	love.graphics.setCanvas(cathode)
	local imageData = canvas:getImageData()

	for y=0,height-1 do
		local punit = unit
		if math.random() > 1-modifier[1] then
			unit = unit + math.random(0,modifier[2])
		end
		for x=0,width-1 do

			local i = x+y*width

			if math.random() > 1-modifier[3] then	
				unit = unit/modifier[4]
				i = i*modifier[2]
			end

			local r,g,b,a = imageData:getPixel(x,y)
			--red
			love.graphics.setColor(r,0,0,a)
			love.graphics.rectangle("fill", ((i%width)*unit)-unit, ((((i-i%width)/width))*unit)+((unit/3)*0), unit, (unit/3))
			--green
			love.graphics.setColor(0,g,0,a)
			love.graphics.rectangle("fill", ((i%width)*unit)-unit, ((((i-i%width)/width))*unit)+((unit/3)*1), unit, (unit/3))
			--blue
			love.graphics.setColor(0,0,b,a)
			love.graphics.rectangle("fill", ((i%width)*unit)-unit, ((((i-i%width)/width))*unit)+((unit/3)*2), unit, (unit/3))
		end
		unit = punit
	end

	love.graphics.setCanvas(actual_canvas)
	return cathode

end

print("\nCathode Lib 0.8 initialized. Have fun !\n")
