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
-- screenMenu.lua
------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------
-- Require all of the external modules for this level
---------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

local myGlobalData 		= require( "globalData" )

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
	--Background Image
	local bg = display.newImageRect(myGlobalData.imagePath.."homeScreen.png",568,384)
	bg.x = display.contentWidth * 0.5
	bg.y = display.contentHeight * 0.5
	bg.alpha=1
	sceneGroup:insert( bg )

	--Start Button
	local startButton = display.newImageRect(myGlobalData.imagePath.."buttonStart.png",131,49)
	startButton.x = display.contentWidth * 0.5
	startButton.y = (display.contentHeight * 0.5)+120
	startButton.alpha=1
	startButton:addEventListener( "touch", touchStart)
	sceneGroup:insert( startButton )

end



---------------------------------------------------------------
-- start game button
---------------------------------------------------------------
function startGame()
	composer.gotoScene( "screenResetLevel")
end
function touchStart(event)
	if(event.phase == "began") then
	elseif(event.phase == "ended") then
		startGame()
  end
end


-- "scene:show()"
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
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
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end

-- "scene:destroy()"
function scene:destroy( event )

   local sceneGroup = self.view

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
