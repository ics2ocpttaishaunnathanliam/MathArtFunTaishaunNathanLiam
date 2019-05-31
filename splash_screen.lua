-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Liam Csiffary
-- Date: April 17, 2019
-- Description: This is the splash screen of the game. It displays the 
-- company logo that rotates across the screen then appears in the middle
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
-- create company logo
local companyLogo 

local companyLogo2

-- set the scroll speed
local scrollSpeed = 14

-- create local for rotation
local rotate = 0

local visible = 0

local scale = 1

----------------------------------------------------------------------------------------
-- LOCAL SOUND VARIABLES
-----------------------------------------------------------------------------------------
local bkgMusicLevel1 = audio.loadStream("Sounds/level1Music.mp3")
local bkgMusicLevel1Channel = audio.play(bkgMusicLevel1, { channel=6, loops=-1 } )


--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

local function Mute(touch)
    if (touch.phase == "ended") then
        audio.pause(bkgMusicMM)
        soundOn = false
        muteButton.isVisible = false
        unmuteButton.isVisible = true
    end
end

local function UnMute(touch)
    if (touch.phase == "ended") then
        audio.resume(bkgMusicMM)
        soundOn = true
        muteButton.isVisible = true
        unmuteButton.isVisible = false
    end
end

local function AnimateCompanyLogo(event)
    -- add the scroll speed to the x co-ordinate of the logo
    companyLogo.x = companyLogo.x + scrollSpeed

    rotate = rotate + scrollSpeed

    companyLogo.alpha = visible + .5

    companyLogo:scale( scale, scale )

    scale = scale + .00025

    visible = visible + .005
    companyLogo.rotation = rotate
end

local function PopUpLogo()
    companyLogo2.isVisible = true
    companyLogo.isVisible = false
end
-----------
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    companyLogo = display.newImageRect("Images/CompanyLogoNathanC@2x.png", 100, 100)
    companyLogo.x = 0
    companyLogo.y = display.contentHeight/2

    companyLogo2 = display.newImageRect("Images/CompanyLogoNathanC@2x.png", 100, 100)
    companyLogo2.isVisible = false
    companyLogo2.x = display.contentWidth/2
    companyLogo2.y = display.contentHeight/2
    companyLogo2:scale(3.5, 3.5)

    muteButton = display.newImageRect("Images/Mute.png", 200, 200)
    muteButton.x = display.contentWidth*1.5/10
    muteButton.y = display.contentHeight*1.3/10
    muteButton.isVisible = true

    unmuteButton = display.newImageRect("Images/UnMute.png", 200, 200)
    unmuteButton.x = display.contentWidth*1.5/10
    unmuteButton.y = display.contentHeight*1.3/10
    unmuteButton.isVisible = false

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( companyLogo )
    sceneGroup:insert( companyLogo2 )

    sceneGroup:insert( muteButton )
    sceneGroup:insert( unmuteButton )    

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        jungleSoundsChannel = audio.play(jungleSounds )

        -- Call the moveBeetleship function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", AnimateCompanyLogo)
       
        bkgMusicLevel1Channel = audio.play(bkgMusic)
        muteButton:addEventListener("touch", Mute)
        unmuteButton:addEventListener("touch", UnMute)

        timer.performWithDelay(2000, PopUpLogo)
        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  
    bkgMusicLevel1Channel = audio.stop()
    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop()
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
