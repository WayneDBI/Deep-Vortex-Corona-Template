------------------------------------------------------------------------------------------------------------------------------------
-- DEEP VORTEX Corona SDK Template
------------------------------------------------------------------------------------------------------------------------------------
-- Developed by Deep Blue Apps.com [www.deepbueapps.com]
------------------------------------------------------------------------------------------------------------------------------------
-- Abstract: Move the player around, avoiding the obsticles.
------------------------------------------------------------------------------------------------------------------------------------
-- Release Version 4.0
-- Code developed for CORONA SDK STABLE RELEASE 2906
-- 15th July 2016
------------------------------------------------------------------------------------------------------------------------------------
-- screenStart.lua
------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------
-- Require all of the external modules for this level
---------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

local myGlobalData 		= require("globalData")
local loadsave 			= require("loadsave")
local physics 			= require("physics")

---------------------------------------------------------------
-- Define our SCENE variables and sprite object variables
---------------------------------------------------------------
local scene 			= composer.newScene()
local gameOver 			= false
local invincibleMode 	= false   -- set to true to NEVER GET KILLED!

local starsGroup = display.newGroup()
local star

local restartButton
local homeButton

--Math functions
local Cos = math.cos
local Sin = math.sin
local Rad = math.rad
local Atan2 = math.atan2
local Deg = math.deg 
local degrees = 1
local angle = 0 --Start angle

local bgCircles = {}
local wall = {}

local playCentreOffset = 100
local player
local playerLineTrack1
local playerLineTrack2
local enableExtraHuds 			= false
local enableEnhancedBGEffects 	= true  -- Dancing rings etc (uses a lot of FPS)
local enableStarFieldBGEffects 	= true  -- Starfield effect (uses a lot of FPS)
local enableRings				= true

local scaleStart = 100
local scaleIncrements = 0.005
local scaleValue = 0.1

local scaleRingStart = 18
local scaleEnd = 0.2
local scaleSafe = 0.4
local scaleHitPlayer = 1.5

local rotationSpeed = 0.9
local iteratorSpeed = 14000 -- HOW FAST THE RINGS MOVE (Smaller = Faster !!)

local playerMoveSpeed = 8
local playerGoLeft = false
local playerGoRight = false

local angle = 90 --Start angle

local playerBase
local playerHitSize = 12   --Hit Zone of player in radius
local playerInfoDisplay

local scoreNumber = 0
local scoreDisplay
local highScoreDisplay

local scoreTimertimer

local audioTrackTime = 70.368
local audioTimePoint1 = 5.855
local audioTimePoint2 = 13
local audioTimePoint3 = 24
local audioTimePoint4 = 26
local audioTimePoint5 = 33 -- crazy bit - blue
local audioTimePoint6 = 35.23
local audioTimePoint7 = 37.01
local audioTimePoint8 = 39.56 -- start of slow
local audioTimePoint9 = 51.103 -- ending slow
local audioTimePoint10 = 62.68 -- start very slow
local audioTimePoint11 = 64.26 -- end v slow
local audioTimePoint12 = 68.73 -- to end

local audioLoops = 1

local startTime = system.getTimer()

---------------------------------------------------------------------------------------------------------
-- explode ship properties 
---------------------------------------------------------------------------------------------------------
local minexplodeParticleRadius		= 2
local maxexplodeParticleRadius		= 222
local numOfexplodeParticleParticles	= 20
local explodeParticleFadeTime 		= 600
local explodeParticleFadeDelay 		= 80
local minexplodeParticleVelocityX 	= -250
local maxexplodeParticleVelocityX 	= 250
local minexplodeParticleVelocityY 	= -250
local maxexplodeParticleVelocityY 	= 250
local explodeChoppedProp 			= {density = 1.0, friction = 0.3, bounce = 0.2, filter = {categoryBits = 4, maskBits = 8} } 
local explodeTransition


---------------------------------------------------------------------------------------------------------
-- Localise some global variables
---------------------------------------------------------------------------------------------------------
local sizeGetW = myGlobalData._w
local sizeGetH = myGlobalData._h
local imagePath = myGlobalData.imagePath

--If we're NOT on an iPhone 5 - have less pixels  things going on!....
local maxCircles = 3
local maxStars = 6

--If we're on an iPhone 5 - have more pixels n stars etc !
if (myGlobalData.iPhone5 == true) then
	print("----iPhone 5---")
	 maxCircles = 4
	 maxStars = 10
end
-----------------------------------------------------------------
-- Setup the Physics World
-----------------------------------------------------------------
physics.start()
physics.setScale( 30 )
physics.setGravity( 0, 0 )
physics.setPositionIterations(2)

-- un-comment to see the Physics world over the top of the Sprites
--physics.setDrawMode( "hybrid" )

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end

-- "scene:show()"
function scene:show( event )

   local screenGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
      
-- Touch Left & Right areas
	---------------------------------------------------------------
	local goLeft = display.newRect(0,0,display.contentWidth*0.5,display.contentHeight)
	goLeft.x = (display.contentWidth/4)
	goLeft.y = (display.contentHeight*0.5)
	goLeft:setFillColor(0,0,0)
	goLeft.alpha=0.1
	screenGroup:insert( goLeft )

	local goRight = display.newRect(0,0,display.contentWidth*0.5,display.contentHeight)
	goRight.x = display.contentWidth - (display.contentWidth/4)
	goRight.y = (display.contentHeight*0.5)
	goRight:setFillColor(0,0,0)
	goRight.alpha=0.1
	screenGroup:insert( goRight )
	
	---------------------------------------------------------------
	-- Add event listeners to the touch areas
	---------------------------------------------------------------
	goLeft:addEventListener( "touch", rightTouch)
	goRight:addEventListener( "touch", leftTouch)


	---------------------------------------------------------------
	-- Add event listeners for the Keyboard IF IN SIMULATOR
	---------------------------------------------------------------
	-- Add the key event listener
	if ( system.getInfo( "environment" ) == "simulator" ) then
    	print( "You're in the Corona Simulator." )
		Runtime:addEventListener( "key", onKeyEvent )
	end
	---------------------------------------------------------------
	-- Draw the circles to animate on the screen
	---------------------------------------------------------------
	local function makeCircle( x,y,r)
		cir = display.newCircle( x,y,r)
		cir.strokeWidth = 40
		cir:setStrokeColor(1,1,1,0.09)
		cir:setFillColor(0,0,0,0)
		return cir
	end
	
	if(enableEnhancedBGEffects==true) then
		local index = 1
		for i=1, maxCircles do
			bgCircles[ index ] = makeCircle( display.contentCenterX, display.contentCenterY, 10*i )
			screenGroup:insert( bgCircles[ #bgCircles ] )
			index = index + 1
		end
	end
	
	---------------------------------------------------------------
	-- Draw the star field
	---------------------------------------------------------------
	if (enableStarFieldBGEffects==true) then
		for i = 1,maxStars do
			star = display.newCircle( starsGroup, 1,1,1)--math.random(0,display.contentWidth), math.random(0, display.contentHeight), 1 )
			star:setFillColor(1,1,1,0.4)
		end
		screenGroup:insert( starsGroup )
	end

	---------------------------------------------------------------
	-- Add the 3 primary hit zones / rotating walls
	---------------------------------------------------------------
	if (enableRings==true) then
		local startScale = 4
		local physicsData = (require "wheel_PhysicsData").physicsData(startScale)
		wall[1] = display.newImageRect(imagePath.."wheel1.png",256,256)
		wall[1].myName = "hazard"
		wall[1].doKill = false
		wall[1].x = sizeGetW*0.5
		wall[1].y = sizeGetH*0.5
		wall[1].xScale = startScale
		wall[1].yScale = startScale
		physics.addBody( wall[1], physicsData:get("wheel"..1) )
		wall[1].isFixedRotation = true
		wall[1].isSensor = true
		wall[1].rotation = 0
		screenGroup:insert( wall[1] )
	
		local startScale = 14
		local physicsData = (require "wheel_PhysicsData").physicsData(startScale)
		wall[2] = display.newImageRect(imagePath.."wheel2.png",256,256)
		wall[2].myName = "hazard"
		wall[2].doKill = false
		wall[2].x = sizeGetW*0.5
		wall[2].y = sizeGetH*0.5
		wall[2].xScale = startScale
		wall[2].yScale = startScale
		physics.addBody( wall[2], physicsData:get("wheel"..2) )
		wall[2].isFixedRotation = true
		wall[2].isSensor = true
		wall[2].rotation = 90
		screenGroup:insert( wall[2] )
		
		local startScale = 64
		local physicsData = (require "wheel_PhysicsData").physicsData(startScale)
		wall[3] = display.newImageRect(imagePath.."wheel3.png",256,256)
		wall[3].myName = "hazard"
		wall[3].doKill = false
		wall[3].x = sizeGetW*0.5
		wall[3].y = sizeGetH*0.5
		wall[3].xScale = startScale
		wall[3].yScale = startScale
		physics.addBody( wall[3], physicsData:get("wheel"..3) )
		wall[3].isFixedRotation = true
		wall[3].isSensor = true
		wall[3].rotation = 180
		screenGroup:insert( wall[3] )
	end
	
	---------------------------------------------------------------
	-- Add an overlay grid (optional)
	---------------------------------------------------------------
	local bgTop = display.newImageRect(imagePath.."bg1.png",568,384)
	bgTop.x = sizeGetW*0.5
	bgTop.y = sizeGetH*0.5
	bgTop.xScale = 2.0
	bgTop.yScale = 2.0
	bgTop.alpha=0.2
	screenGroup:insert( bgTop )

	-----------------------------------------------------------------
	-- Add Score
	-----------------------------------------------------------------
	local scoreHudPanel = display.newImageRect(imagePath.."hudPanel.png",164,56)
	scoreHudPanel.anchorX = 1
	scoreHudPanel.anchorY = 0
	scoreHudPanel.xScale = 2.0
	scoreHudPanel.yScale = 2.0
	scoreHudPanel.x = sizeGetW+100
	scoreHudPanel.y = -40
	scoreHudPanel.alpha = 0.0
	screenGroup:insert( scoreHudPanel )

	scoreDisplay = display.newText("Score: "..scoreNumber,0,0, "HelveticaNeue-Condensed", 20)
	scoreDisplay:setFillColor(1,1,1)
	scoreDisplay.anchorX = 0
	scoreDisplay.x = sizeGetW - 130
	scoreDisplay.y = 20
	scoreDisplay.alpha = 1
	screenGroup:insert( scoreDisplay )

	-----------------------------------------------------------------
	-- Show HighScore
	-----------------------------------------------------------------
	local scoreHudPanel = display.newImageRect(imagePath.."hudPanel.png",164,56)
	scoreHudPanel.anchorX = 1
	scoreHudPanel.anchorY = 0
	scoreHudPanel.xScale = -2.0
	scoreHudPanel.yScale = 2.0
	scoreHudPanel.x = -100
	scoreHudPanel.y = -40
	scoreHudPanel.alpha = 0.0
	screenGroup:insert( scoreHudPanel )

	highScoreDisplay = display.newText("High score: "..saveDataTable.highScore,0,0, "HelveticaNeue-Condensed", 20)
	highScoreDisplay:setFillColor(1,1,1)
	highScoreDisplay.anchorX = 0
	highScoreDisplay.x = 20
	highScoreDisplay.y = 20
	highScoreDisplay.alpha = 0.6
	screenGroup:insert( highScoreDisplay )

	---------------------------------------------------------------
	--restart button
	---------------------------------------------------------------
	restartButton = display.newImageRect(imagePath.."buttonReset.png",35,39)
	restartButton.xScale = 1.4
	restartButton.yScale = 1.4
	restartButton.x = 45
	restartButton.y = 60--sizeGetH-45
	restartButton.alpha = 0.6
	restartButton:addEventListener( "touch", restartTouched )
	screenGroup:insert( restartButton )

	---------------------------------------------------------------
	--quit/home button
	---------------------------------------------------------------
	homeButton = display.newImageRect(imagePath.."buttonHome.png",36,38)
	homeButton.xScale = 1.4
	homeButton.yScale = 1.4
	homeButton.x = sizeGetW-45
	homeButton.y = 60--sizeGetH-45
	homeButton.alpha = 0.6
	homeButton:addEventListener( "touch", homeTouched )
	screenGroup:insert( homeButton )

	---------------------------------------------------------------
	--Circumference rotate around
	---------------------------------------------------------------
	local getMaxWidth = display.contentHeight*0.5
	playerBase = display.newCircle( display.contentCenterX, display.contentCenterY, 1 )
	playerBase.alpha = 0.0
	screenGroup:insert( playerBase )

	---------------------------------------------------------------
	--Add the player
	---------------------------------------------------------------
	local playerStartScale = 0.5
	local physicsData = (require "wheel_PhysicsData").physicsData(playerStartScale)
	player = display.newImageRect(imagePath.."player.png",28,28)
	physics.addBody( player, "dynamic", physicsData:get("player") )
	--player.isSleepingAllowed = false
	player.isSensor = true
	player.myName = "player"
	player.xScale = playerStartScale
	player.yScale = playerStartScale
	player.rotation = 180
	player.x = sizeGetW*0.5
	player.y = display.contentHeight-playCentreOffset
	screenGroup:insert( player )

	---------------------------------------------------------------
	--Some extra info - but needs a FAST CPU to run smooth!
	---------------------------------------------------------------
	if (enableExtraHuds==true) then
		-----------------------------------------------------------------
		-- Add player Angle info....
		-----------------------------------------------------------------
		playerInfoDisplay = display.newText(player.rotation.."º",0,0, "HelveticaNeue-Condensed", 12)
		playerInfoDisplay:setFillColor(1,1,1)
		playerInfoDisplay.anchorX = 0
		playerInfoDisplay.anchorY = 0.5
		playerInfoDisplay.xScale = 1.0
		playerInfoDisplay.yScale = 1.0
		playerInfoDisplay.x = player.x+(player.contentWidth*0.5)
		playerInfoDisplay.y = player.y-- + (player.contentHeight)
		playerInfoDisplay.alpha = 0.5
		screenGroup:insert( playerInfoDisplay )

		--eye candy - lines tracking the player pos
		playerLineTrack1 = display.newLine( 0,display.contentHeight, player.x, player.y )
		playerLineTrack1:setStrokeColor( 1, 1, 1, 0.2)
		playerLineTrack1.strokeWidth = 1
		screenGroup:insert( playerLineTrack1 )

		playerLineTrack2 = display.newLine( sizeGetW*0.5,sizeGetH*0.5, player.x, player.y )
		playerLineTrack2:setStrokeColor( 1, 1, 1, 0.2)
		playerLineTrack2.strokeWidth = 1
		screenGroup:insert( playerLineTrack2 )
	end
	
	---------------------------------------------------------------
	--add mini logo
	---------------------------------------------------------------
	local miniLogo = display.newImageRect(imagePath.."miniLogo.png",154,34)
	miniLogo.xScale = 1.0
	miniLogo.yScale = 1.0
	miniLogo.anchorX = 0
	miniLogo.x = 10--sizeGetW-45
	miniLogo.y = sizeGetH-20
	miniLogo.alpha = 1.0
	screenGroup:insert( miniLogo )

	-----------------------------------------------------------------
	--Reserve Channels 1, 2, 3 for Specific audio
	-----------------------------------------------------------------
	audio.reserveChannels( 4 )	

   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
      
	-----------------------------------------------------------------
	-- Stop the GAME music playing on channel 2
	-----------------------------------------------------------------
 	audio.stop(1)

	-----------------------------------------------------------------
	-- Start the MENU Music - Looping
	-----------------------------------------------------------------		
	audio.play(musicGame, {channel=1, loops = -1})


	-----------------------------------------------------------------
	--Update the score every 0.10 seconds
	-----------------------------------------------------------------		
	local function trackTimeUpdate()   -- RunTime enterFrame event handler
		local round = math.round
		scoreNumber = round( (((scoreNumber)+0.02)*100) ) *0.01 		
	end
	scoreTimertimer = timer.performWithDelay( 10, trackTimeUpdate,10000)		
      
   end
end



local function touch( event )
		player.x, player.y = event.x, event.y
	return true
end

---------------------------------------------------------------------------------------------------------
-- create a exploding sequence for each of the biscuit parts
---------------------------------------------------------------------------------------------------------
local function explodePlayer()
	for  i = 1, numOfexplodeParticleParticles do
		local random = math.random
		local rndSize = random(1,1)
		local explodeParticle = display.newRect(0,0,rndSize,rndSize)
		--screenGroup:insert( explodeParticle )
		explodeParticle:setFillColor(1,0.8,0.1)
		explodeParticle.x=player.x
		explodeParticle.y=player.y
		explodeParticle.xScale = 1.3
		explodeParticle.yScale = 1.3
		explodeChoppedProp.radius = explodeParticle.width *0.5
		physics.addBody(explodeParticle, "dynamic", explodeChoppedProp)

		---------------------------------------------------------------------------------------------------------
		-- set each of the exploded biscuit bits with a random X, Y velocity.
		---------------------------------------------------------------------------------------------------------
		local xVelocity = random(minexplodeParticleVelocityX, maxexplodeParticleVelocityX)
		local yVelocity = random(minexplodeParticleVelocityY, maxexplodeParticleVelocityY)
		explodeParticle:setLinearVelocity(xVelocity, yVelocity)
		explodeTransition = transition.to(explodeParticle, {time = explodeParticleFadeTime, delay = explodeParticleFadeDelay, alpha=0, onComplete = function(event) display.remove(explodeParticle) end})		
	end				
end


---------------------------------------------------------------
--Handle Collisions
---------------------------------------------------------------
local function onGlobalCollision( event )

	if ( gameOver==false) then
		if ( invincibleMode==false) then
	
			if ( event.phase == "began" ) then
	
				--print( "Global report: " .. event.object1.myName .. " & " .. event.object2.myName .. " collision began" )
	
				--Check to see if it's game over!
				if (event.object1.myName == "player" and event.object2.myName == "hazard") then
					local function gameEnd()
						gameOver = true
						audio.play(Sfx_Hit)
						--Call the Explode Player functions
						explodePlayer()
					end
					timer.performWithDelay(5, gameEnd )
				end 
		
				--Check to see if it's game over!
				if (event.object1.myName == "hazard" and event.object2.myName == "player") then
					local function gameEnd()
						gameOver = true
						audio.play(Sfx_Hit)
						--Call the Explode Player functions
						explodePlayer()
					end
					timer.performWithDelay(5, gameEnd )
				end 

			elseif ( event.phase == "ended" and gameOver==false) then
	
			end
	
		end
	end
	
end


	
---------------------------------------------------------------
-- Update for the audio tracker / timer
---------------------------------------------------------------

local function trackAudioTime()

	local interval = (system.getTimer() - startTime)/1000
	
	local randomAlpha = math.random(1)/5
	local randomWidth = math.random(200)/1
	local random = math.random

	--see if the timer for the music/effect needs resetting to 0
	if (interval >= audioTrackTime) then
		startTime = system.getTimer()
		local interval = (system.getTimer() - startTime)/1000
	end

	-- bg rings effect
	if (enableEnhancedBGEffects==true) then
		for j=1, maxCircles do
			local target = bgCircles[j]
			local getSize = target.contentWidth
			local dispWidth = display.contentWidth
			local currentScale = target.xScale
			
			if (getSize > dispWidth) then
				target.xScale = 0.1
				target.yScale = 0.1
			else

				local scaleValue = (currentScale  + (scaleIncrements)) + getSize/(iteratorSpeed*0.1)
				target.xScale = scaleValue
				target.yScale = scaleValue
			end

						--Fun with the music / colours
			if (interval < audioTimePoint1  ) then
				target:setStrokeColor(1,1,1,randomAlpha)
				target.strokeWidth = 30--randomWidth
			elseif (interval >= audioTimePoint1 and interval <= audioTimePoint2 ) then
				target:setStrokeColor(0.9,0.2,0.1, randomAlpha) --red
				target.strokeWidth = randomWidth
			elseif (interval > audioTimePoint2 and interval <= audioTimePoint3 ) then
				target:setStrokeColor(random(0.0,0.6),random(0.0,1.0),random(0.0,0.3), randomAlpha)
				--target.strokeWidth = (random(20)/1)
			elseif (interval > audioTimePoint3 and interval <= audioTimePoint4 ) then
				target:setStrokeColor(0.1,0.2,random(0.0,1.0), randomAlpha) --dirty blue
			elseif (interval > audioTimePoint4 and interval <= audioTimePoint5 ) then
				target:setStrokeColor(random(0.0,0.7),random(0.0,0.6),random(0.0,1.0), randomAlpha)
				target.strokeWidth = randomWidth
			elseif (interval > audioTimePoint5 and interval <= audioTimePoint6 ) then
				target:setStrokeColor(0.1,0.2,random(0.0,1.0),randomAlpha) --dirty blue
			elseif (interval > audioTimePoint6 and interval <= audioTimePoint7 ) then
				target:setStrokeColor(random(0.0,1.0),0.1,random(0.0,1.0),randomAlpha) --dirty yellow
			elseif (interval > audioTimePoint7 and interval <= audioTimePoint8 ) then
				target:setStrokeColor(random(0.7,1.0),random(0.4,0.5),random(0.9,1.0),randomAlpha) --dirty yellow
			elseif (interval > audioTimePoint8 and interval <= audioTimePoint9 ) then
				target:setStrokeColor(random(0.99,1.0),random(0.9,1.0),random(0.56,0.6),randomAlpha) --dirty yellow
				target.strokeWidth = randomWidth
			elseif (interval > audioTimePoint9 and interval <= audioTimePoint10 ) then
				target:setStrokeColor(1,1,1, randomAlpha)
				target.strokeWidth = 30--randomWidth
			elseif (interval > audioTimePoint10 and interval <= audioTimePoint11 ) then
				target:setStrokeColor(0.1,0.2,random(0.0,1.0), randomAlpha) --dirty blue
			elseif (interval > audioTimePoint11 and interval <= audioTimePoint12 ) then
				target:setStrokeColor(random(0.0,1.0),0.1,random(0.0,1.0), randomAlpha) --dirty yellow
			else
				target:setStrokeColor(random(0.0,0.6),random(0.0,1.0),random(0.0,0.3), randomAlpha)
			end
			
			
		end
	end
	
end

---------------------------------------------------------------
--Extra HUD info function - only enable for fast CPU
---------------------------------------------------------------
local function updatePlayerInfoAngle()

	if (enableExtraHuds==true) then
		display.remove(playerLineTrack1)
		playerLineTrack1 = nil
		display.remove(playerLineTrack2)
		playerLineTrack2 = nil
		
		local round = math.round
		playerInfoDisplay.text = round(player.rotation).."º"
		playerInfoDisplay.x = player.x+(player.contentWidth*0.5)
		playerInfoDisplay.y = player.y-- + (player.contentHeight)
		playerInfoDisplay.alpha = 0.5
	
		--eye candy - lines tracking the player pos
		playerLineTrack1 = display.newLine( 0,display.contentHeight, player.x, player.y )
		playerLineTrack1:setStrokeColor( 1, 1, 1, 0.2)
		playerLineTrack1.strokeWidth = 1
	
		playerLineTrack2 = display.newLine( sizeGetW*0.5,sizeGetH*0.5, player.x, player.y )
		playerLineTrack2:setStrokeColor( 1, 1, 1, 0.2)
		playerLineTrack2.strokeWidth = 1
	end

end

---------------------------------------------------------------
--Function to update the star field
---------------------------------------------------------------
local starVelocity = 3 --Experiment with different values according to the velocity you want
function moveStars()

	--if (gameOver==false) then
		  local star
		  local abs = math.abs
		  local random = math.random
		  for i = 1,starsGroup.numChildren do
			star = starsGroup[i]
			local x = star.x; local y = star.y
			local difX = abs(x-display.contentCenterX)
			local difY = abs(y-display.contentCenterY)

			if x <=  display.contentCenterX and y <=  display.contentCenterY then  -- q1
			  star.x = x - (starVelocity * difX / difY); star.y = y - starVelocity
			  elseif x >=  display.contentCenterX and y <=  display.contentCenterY then -- q2
			  star.x = x + (starVelocity * difX / difY); star.y = y - starVelocity
			  elseif x <=  display.contentCenterX and y >=  display.contentCenterY then -- q3
			  star.x = x - (starVelocity * difX / difY); star.y = y + starVelocity
			  elseif x >=  display.contentCenterX and y >=  display.contentCenterY then -- q4
			  star.x = x + (starVelocity * difX / difY); star.y = y + starVelocity
			end

			if star.x >=  display.contentWidth or star.x <=  0 or star.y >=  display.contentHeight or star.y <=  0 then
			  star:removeSelf()
			  star = display.newCircle( starsGroup, random(0,display.contentWidth), random(0, display.contentHeight), 1 )
			  star:setFillColor(1,1,1,0.4)
			end
		  end
	--end
end

---------------------------------------------------------------
-- Update the background rings outside of the main UpdateTick
---------------------------------------------------------------
function updateBGRings(event)
	------------------------------------------------------------
	--call the track Audio function:
	------------------------------------------------------------
	if (enableEnhancedBGEffects==true) then
		trackAudioTime()
	end
end

---------------------------------------------------------------
-- Update Animations every tick/cycle
---------------------------------------------------------------
function updateTick(event)
	

	if (gameOver == false) then


		------------------------------------------------------------
		--Update the star field within the updateTick if enabled:
		------------------------------------------------------------
		if (enableStarFieldBGEffects==true) then
			moveStars()
		end
		------------------------------------------------------------


		--Update Score
		scoreDisplay.text = ("Score: "..scoreNumber)
		scoreDisplay.alpha = 0.6
		scoreDisplay.alpha = 0.6

	
		--Do we need to update the highScore?
		if 	(scoreNumber > myGlobalData.highScore) then
			myGlobalData.highScore = scoreNumber
			highScoreDisplay.text = "High score: "..myGlobalData.highScore
			highScoreDisplay:setFillColor(1,1,1)
			highScoreDisplay.alpha = 0.6
		end
		
		--move the walls / resize / rotate
		if (enableRings==true) then
			for i=1, 3 do

				if (wall[i].xScale <= scaleEnd) then
					wall[i].xScale = scaleRingStart
					wall[i].yScale = scaleRingStart		
				else

					local getSize = wall[i].contentWidth
					scaleValue = (wall[i].xScale  - scaleIncrements) - getSize/iteratorSpeed

					wall[i].xScale = scaleValue
					wall[i].yScale = scaleValue

					if ( scaleValue <= 2 and scaleValue > scaleSafe) then
						local physicsData = (require "wheel_PhysicsData").physicsData(scaleValue)
						--local metimer = timer.performWithDelay(12, function() physics.removeBody( wall[i] ) end )

						physics.removeBody(wall[i]) 
						physics.addBody( wall[i], physicsData:get("wheel"..i) )
						wall[i].isSensor = true
						--physics.removeBody(wall[i]) 

					elseif ( scaleValue <= scaleSafe ) then
						--physics.removeBody(wall[i])
					end
					
					wall[i].x = sizeGetW*0.5
					wall[i].y = sizeGetH*0.5
				end
			
				if (i==2) then
					wall[i].rotation = wall[i].rotation + rotationSpeed
				else
					wall[i].rotation = wall[i].rotation - rotationSpeed	
				end
		
			end
		end

		-- Rotate the player around the centre..
		if (playerGoRight == true) then
			
			playerBase.rotation = playerBase.rotation + playerMoveSpeed
			player.x = playerBase.x  + Cos(Rad(angle)) * ((display.contentHeight*0.5)-playCentreOffset) 
			player.y = playerBase.y  + Sin(Rad(angle)) * ((display.contentHeight*0.5)-playCentreOffset)
			local angleBetween = Atan2(playerBase.y-player.y, playerBase.x-player.x)
			player.rotation = Deg(angleBetween)-90
			angle = angle + playerMoveSpeed
			if (enableExtraHuds==true) then
				updatePlayerInfoAngle()
			end
			
		elseif (playerGoLeft == true) then
	
			playerBase.rotation = playerBase.rotation + playerMoveSpeed
			player.x = playerBase.x  + Cos(Rad(angle)) * ((display.contentHeight*0.5)-playCentreOffset) 
			player.y = playerBase.y  + Sin(Rad(angle)) * ((display.contentHeight*0.5)-playCentreOffset)
			local angleBetween = Atan2(playerBase.y-player.y, playerBase.x-player.x)
			player.rotation = Deg(angleBetween)+270
			angle = angle - playerMoveSpeed
			if (enableExtraHuds==true) then
				updatePlayerInfoAngle()
			end
			
		end
	
	--[[
	------------------------------------------------------------
	--Update the star field within the updateTick if enabled:
	------------------------------------------------------------
	if (enableStarFieldBGEffects==true) then
		moveStars()
	end
	------------------------------------------------------------

	------------------------------------------------------------
	--call the track Audio function:
	------------------------------------------------------------
	if (enableEnhancedBGEffects==true) then
		trackAudioTime()
	end
	--]]
	
	
	else
	
		print("END-------------------")
		-- GAME OVER !
		--> Cancel the timer
		if(scoreTimertimer) then
			timer.cancel(scoreTimertimer)
			scoreTimertimer = nil
		end
	
		player.alpha = 0.0
	
		--save the HighScore
		saveDataTable.highScore 			= myGlobalData.highScore
		loadsave.saveTable(saveDataTable, myGlobalData.saveDataName)

		--reposition score fields
		scoreDisplay.anchorX = 0.5
		scoreDisplay.x = sizeGetW*0.5
		scoreDisplay.y = (sizeGetH*0.5)-30
		highScoreDisplay.alpha = 0.7
	
		highScoreDisplay.anchorX = 0.5
		highScoreDisplay.x = sizeGetW*0.5
		highScoreDisplay.y = (sizeGetH*0.5)
		highScoreDisplay.alpha = 0.8

		restartButton.anchorX = 0.5
		restartButton.x = (sizeGetW*0.5)-25
		restartButton.y = (sizeGetH*0.5)+50
		restartButton.alpha = 0.8

		homeButton.anchorX = 0.5
		homeButton.x = (sizeGetW*0.5)+25
		homeButton.y = (sizeGetH*0.5)+50
		homeButton.alpha = 0.8


		--Stop events
		Runtime:removeEventListener( "enterFrame", updateTick )
		Runtime:removeEventListener ( "collision", onGlobalCollision )

		--remove the rings/walls
		if (enableRings==true) then
			for i=1, 3 do
				--physics.removeBody(wall[i])
				wall[i]:removeSelf()
				wall[i]=nil
			end
		end


	end

end

---------------------------------------------------------------
-- PLAY button function
---------------------------------------------------------------
local function buttonPlay()
	audio.play(sfx_Select)
	
	changeTheScene = true
	dataReset.VariableReset()

	composer.gotoScene( "screenWorldSelect", "crossFade", 200  )
	return true
end

---------------------------------------------------------------
-- OPTIONS button function
---------------------------------------------------------------
local function buttonOptions()
	local audioPlay = audio.play(sfx_Select)
	
	changeTheScene = true
	composer.gotoScene( "screenOptions", "crossFade", 200  )
	return true
end

function leftTouch(event)
	if(event.phase == "began") then
	print("left")
		playerGoLeft = true
	elseif(event.phase == "ended") then
		playerGoLeft = false
	end
end

function rightTouch(event)
	if(event.phase == "began") then
	print("right")
		playerGoRight = true
	elseif(event.phase == "ended") then
		playerGoRight = false
  end
end

-----------------------------------------------------------------
-- For Simulator testing - the arrow keys trigger left & right.
-- Space for restart. Enter to quit.
-----------------------------------------------------------------
-- Called when a key event has been received
function onKeyEvent( event )
    -- Print which key was pressed down/up
    local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
    print( message )

    if ( event.keyName == "left" ) then
		if(event.phase == "down") then
		print("Keyboard Right")
			playerGoRight = true
		elseif(event.phase == "up") then
			playerGoRight = false
	  	end
	end

    if ( event.keyName == "right" ) then
		if(event.phase == "down") then
		print("Keyboard Right")
			playerGoLeft = true
		elseif(event.phase == "up") then
			playerGoLeft = false
	  	end
	end

    -- If the "back" key was pressed on Android or Windows Phone, prevent it from backing out of the app
    if ( event.keyName == "back" ) then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) or ( platformName == "WinPhone" ) then
            return true
        end
    end

    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end

-----------------------------------------------------------------
-- Restart  - Button event
-----------------------------------------------------------------
function restartTouched( event )
	if event.phase == "began" then

	elseif event.phase == "ended" then

		Runtime:removeEventListener( "enterFrame", updateTick )
		Runtime:removeEventListener ( "collision", onGlobalCollision )
		Runtime:removeEventListener( "enterFrame", updateBGRings )

		if ( system.getInfo( "environment" ) == "simulator" ) then
	    	print( "You're in the Corona Simulator." )
			Runtime:removeEventListener( "key", onKeyEvent )
		end


		gameOver = false
		invincibleMode = false
		composer.gotoScene( "screenResetLevel",{time=20})	--This is our start screen
	end

	return true
end

-----------------------------------------------------------------
-- Home  - Button event
-----------------------------------------------------------------
function homeTouched( event )
	if event.phase == "began" then

	elseif event.phase == "ended" then
		Runtime:removeEventListener( "enterFrame", updateTick )
		Runtime:removeEventListener ( "collision", onGlobalCollision )
		Runtime:removeEventListener( "enterFrame", updateBGRings )

		if ( system.getInfo( "environment" ) == "simulator" ) then
	    	print( "You're in the Corona Simulator." )
			Runtime:removeEventListener( "key", onKeyEvent )
		end
		
		gameOver = false
		invincibleMode = false
 		audio.stop(1)
		composer.gotoScene( "screenMenu",{time=20})	--This is our start screen
	end

	return true
end


function cleanUpSceneSprites()

		if (enableExtraHuds==true) then
			display.remove(playerLineTrack1)
			playerLineTrack1 = nil

			display.remove(playerLineTrack2)
			playerLineTrack2 = nil

			display.remove(playerInfoDisplay)
			playerInfoDisplay = nil
		end

		display.remove(scoreDisplay)
		scoreDisplay = nil

		display.remove(highScoreDisplay)
		highScoreDisplay = nil

		display.remove(player)
		player = nil

		if(explodeTransition) then
			transition.cancel(explodeTransition)
			explodeTransition = nil
		end

end

-- "scene:hide()"
function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
      	
      	Runtime:removeEventListener( "enterFrame", updateTick )
		Runtime:removeEventListener ( "collision", onGlobalCollision )
		Runtime:removeEventListener( "enterFrame", updateBGRings )

		if ( system.getInfo( "environment" ) == "simulator" ) then
	    	print( "You're in the Corona Simulator." )
			Runtime:removeEventListener( "key", onKeyEvent )
		end

   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
      print("Gone...")


	   -- Called prior to the removal of scene's view ("sceneGroup").
	   -- Insert code here to clean up the scene.
	   -- Example: remove display objects, save state, etc.
   
	   cleanUpSceneSprites()
   end
end

-- "scene:destroy()"
function scene:destroy( event )

	print("DestroyScene......")
   local sceneGroup = self.view


end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

---------------------------------------------------------------
-- Add game Listener Events
---------------------------------------------------------------
Runtime:addEventListener( "enterFrame", updateTick )
Runtime:addEventListener( "enterFrame", updateBGRings )
Runtime:addEventListener ( "collision", onGlobalCollision )

return scene