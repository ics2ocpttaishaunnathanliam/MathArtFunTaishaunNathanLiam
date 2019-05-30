------------------------------ -----------------------------------------------------------
--
-- credits_screen.lua
-- Created by: Your Name
-- Special thanks to Wal Wal for helping in the design of this framework.
-- Date: Month Day, Year
-- Description: This is the credits page, displaying a back button to the main menu.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "character_select"

-- Creating Scene Object
scene = composer.newScene( sceneName ) -- This function doesn't accept a string, only a variable containing a string


characterNumber = 1
-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local bkg_image

local backButton

local character1
local character2
local character3
local character4

local flyingBall
local flyingBallX = -6000

local muteButton
local unmuteButton

local descText

-----------------------------------------------------------------------------------------
-- Sounds
-----------------------------------------------------------------------------------------

local bkgMusicLevel1 = audio.loadStream("Sounds/level1Music.mp3")
local bkgMusicLevel1Channel = audio.play(bkgMusicLevel1, { channel=12, loops=-1 } )


-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function Moose1()
    character = display.newImageRect("Images/MooseCharacterLiamC.png", 200, 200)
    character.x = display.contentWidth*5/10
    character.y = display.contentHeight*1/10
end

local function Moose2()
    character = display.newImageRect("Images/Moose2.png", 200, 200)
    character.x = display.contentWidth*5/10
    character.y = display.contentHeight*1/10
end

local function Moose3()
    character = display.newImageRect("Images/Moose3.png", 200, 200)
    character.x = display.contentWidth*5/10
    character.y = display.contentHeight*1/10
end

local function Moose4()
    character = display.newImageRect("Images/Moose4.png", 200, 200)
    character.x = display.contentWidth*5/10
    character.y = display.contentHeight*1/10
end

local function Character1Select(touch)
    if (touch.phase == "ended") then
        characterNumber = 1
        character.isVisible = false
        Moose1()
        print(characterNumber)
    end
end

local function Character2Select(touch)
    if (touch.phase == "ended") then
        characterNumber = 2
        character.isVisible = false
        Moose2()
        print(characterNumber)        
    end
end

local function Character3Select(touch)
    if (touch.phase == "ended") then
        characterNumber = 3
        character.isVisible = false
        Moose3()
        print(characterNumber)
    end
end

local function Character4Select(touch)
    if (touch.phase == "ended") then
        characterNumber = 4
        character.isVisible = false
        Moose4()
        print(characterNumber)
    end
end

local function AddTextObjectListeners()

    character1:addEventListener("touch", Character1Select)
    character2:addEventListener("touch", Character2Select)
    character3:addEventListener("touch", Character3Select)
    character4:addEventListener("touch", Character4Select)
end 

local function RemoveTextObjectListeners()

    character1:removeEventListener("touch", Character1Select)
    character2:removeEventListener("touch", Character2Select)
    character3:removeEventListener("touch", Character3Select)
    character4:removeEventListener("touch", Character4Select)
end

local function MoveApple(event)
    flyingBallX = flyingBallX+1
    flyingBall.x = flyingBallX
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

------------------------------------------------------ TRANSITIONS FOR LEVELS --------------------------------------------------------

-- Creating Transitioning Function back to main menu
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "zoomOutInFadeRotate", time = 500})
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND AND DISPLAY OBJECTS
    -----------------------------------------------------------------------------------------
    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImageRect("Images/Level1ScreenNathanC@2x.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    muteButton = display.newImageRect("Images/Mute.png", 200, 200)
    muteButton.x = display.contentWidth*1.5/10
    muteButton.y = display.contentHeight*1.3/10
    muteButton.isVisible = true

    unmuteButton = display.newImageRect("Images/UnMute.png", 200, 200)
    unmuteButton.x = display.contentWidth*1.5/10
    unmuteButton.y = display.contentHeight*1.3/10
    unmuteButton.isVisible = false

    descText = display.newText("Pick your moose!", 10, 10)
    descText.x = display.contentWidth/2
    descText.y = display.contentHeight*3/10
    descText:scale(2, 2)




    flyingBall = display.newImageRect("Images/ApplesNathan@2x.png", 50, 50)
    flyingBall.x = -500
    flyingBall.y = display.contentHeight/2
    flyingBall.isVisible = true

    character = display.newImageRect("Images/MooseCharacterLiamC.png", 200, 200)
    character.x = display.contentWidth*5/10
    character.y = display.contentHeight*1/10
    sceneGroup:insert(character)

    character1 = display.newImageRect("Images/MooseCharacterLiamC.png", 200, 200)
    character1.x = display.contentWidth*1/10
    character1.y = display.contentHeight*5/10
    sceneGroup:insert(character1)

    character2 = display.newImageRect("Images/Moose2.png", 200, 200)
    character2.x = display.contentWidth*3.5/10
    character2.y = display.contentHeight*5/10
    sceneGroup:insert(character2)

    character3 = display.newImageRect("Images/Moose3.png", 200, 200)
    character3.x = display.contentWidth*6/10
    character3.y = display.contentHeight*5/10
    sceneGroup:insert(character3)

    character4 = display.newImageRect("Images/Moose4.png", 200, 200)
    character4.x = display.contentWidth*8.5/10
    character4.y = display.contentHeight*5/10
    sceneGroup:insert(character4)






    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    sceneGroup:insert(flyingBall)
    sceneGroup:insert( muteButton )
    sceneGroup:insert( unmuteButton )
    sceneGroup:insert(descText)
    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*1/8,
        y = display.contentHeight*14/16,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressedYourName@2x.png",
        overFile = "Images/BackButtonPressedYourName@2x.png",

        width = 200,
        height = 100,

        -- Setting Functional Properties
        onRelease = BackTransition

    } )

    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( backButton )

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        AddTextObjectListeners()
        bkgMusicLevel1Channel = audio.play(bkgMusic)
        muteButton:addEventListener("touch", Mute)
        unmuteButton:addEventListener("touch", UnMute)   
        Runtime:addEventListener("enterFrame", MoveApple)
    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        bkgMusicLevel1Channel = audio.stop()
        RemoveTextObjectListeners()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
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

end --function scene:destroy( event )

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