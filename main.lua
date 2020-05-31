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
-- main.lua
------------------------------------------------------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

-- require controller module
local composer = require( "composer" )
local scene = composer.newScene()

local physics 						= require( "physics" )
local myGlobalData 					= require( "globalData" )
local loadsave 						= require("loadsave") -- Require our external Load/Save module

--scaleFactor = 0.5

myGlobalData._w 					= display.contentWidth  		-- Get the devices Width
myGlobalData._h 					= display.contentHeight 		-- Get the devices Height

myGlobalData.levelSizeW 			= display.contentHeight 		-- the screen / BOUNDRY SIZE for each level
myGlobalData.levelSizeH 			= display.contentHeight 		-- the screen / BOUNDRY SIZE for each level

myGlobalData.imagePath				= "_Assets/Images/"
myGlobalData.audioPath				= "_Assets/Audio/"

myGlobalData.iPhone5				= false							-- Which device	

myGlobalData.volumeSFX				= 0.7							-- Define the SFX Volume
myGlobalData.volumeMusic			= 0.1							-- Define the Music Volume
myGlobalData.resetVolumeSFX			= myGlobalData.volumeSFX		-- Define the SFX Volume Reset Value
myGlobalData.resetVolumeMusic		= myGlobalData.volumeMusic		-- Define the Music Volume Reset Value
myGlobalData.soundON				= true							-- Is the sound ON or Off?
myGlobalData.musicON				= true							-- Is the sound ON or Off?

myGlobalData.factorX				= 0.4166	--2.400
myGlobalData.factorY				= 0.46875	--2.133

myGlobalData.saveDataName			= "dba_vc_template_data2016.json" -- Save score & Data to device name.

-- Enable debug by setting to [true] to see FPS and Memory usage.
local doDebug 						= false						-- show the Memory and FPS box?
myGlobalData.showDebugGrid			= false						-- Show a grid to help positioning...

_G.saveDataTable		= {}							-- Define the Save/Load base Table to hold our data


-- Load in the saved data to our game table
-- check the files exists before !
if loadsave.fileExists(myGlobalData.saveDataName, system.DocumentsDirectory) then
	saveDataTable = loadsave.loadTable(myGlobalData.saveDataName)
else
	saveDataTable.highScore 			= 0
	-- Save the NEW json file, for referencing later..
	loadsave.saveTable(saveDataTable, myGlobalData.saveDataName)
end

--Now load in the Data
saveDataTable = loadsave.loadTable(myGlobalData.saveDataName)

--Now assign the LOADED level to the Game Variable to control the levels the user can select.
myGlobalData.highScore				= saveDataTable.highScore		-- Saved HighScore value
myGlobalData.gameScore				= 0								-- Set the Starting value of the score to ZERO ( 0 )

if system.getInfo("model") == "iPad" or system.getInfo("model") == "iPad Simulator" then
	myGlobalData.iPhone5	= false
	myGlobalData.iPad		= true
elseif display.pixelHeight > 960 then
	myGlobalData.iPhone5	= true
	myGlobalData.iPad		= false
end


-- Debug Data
if (doDebug) then
	local fps = require("fps")
	local performance = fps.PerformanceOutput.new();
	performance.group.x, performance.group.y = (display.contentWidth/2)-40,  display.contentWidth/2;
	performance.alpha = 0.3; -- So it doesn't get in the way of the rest of the scene
end


--Set the Music Volume
audio.setVolume( myGlobalData.volumeMusic, 	{ channel=0 } ) -- set the volume on channel 1
audio.setVolume( myGlobalData.volumeMusic, 	{ channel=1 } ) -- set the volume on channel 1
audio.setVolume( myGlobalData.volumeMusic, 	{ channel=2 } ) -- set the volume on channel 2
audio.setVolume( myGlobalData.volumeMusic, 	{ channel=3 } ) -- set the volume on channel 3

for i = 4, 32 do
	audio.setVolume( myGlobalData.volumeSFX, { channel=i } )
end 


function startGame()
	composer.gotoScene( "screenMenu")	--This is our main menu
end


------------------------------------------------------------------------------------------------------------------------------------
-- Preload Audio, music, sfx
------------------------------------------------------------------------------------------------------------------------------------
--musicStart 				= audio.loadSound( myGlobalData.audioPath.."musicDBA001.mp3" )
musicGame					= audio.loadSound( myGlobalData.audioPath.."music.mp3" )

--sfx_Victory				= audio.loadSound( myGlobalData.audioPath.."sfx_Victory.mp3" )
Sfx_Hit					= audio.loadSound( myGlobalData.audioPath.."Sfx_Hit.mp3" )


--Start Game after a short delay.
timer.performWithDelay(5, startGame )

