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
sceneName = "levels_screen"

-- Creating Scene Object
scene = composer.newScene( sceneName ) -- This function doesn't accept a string, only a variable containing a string

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local bkg_image

local backButton

local level1Button
local level2Button
local level3Button
local level4Button

local flyingBall
local flyingBallX = -3000

local muteButton
local unmuteButton

local moose
local mooseXscale = 0

local moose2
local mooseXscale2 = 0

local hiddenText
-----------------------------------------------------------------------------------------
-- Sounds
-----------------------------------------------------------------------------------------

local bkgMusicLevel1 = audio.loadStream("Sounds/level1Music.mp3")
local bkgMusicLevel1Channel = audio.play(bkgMusicLevel1, { channel=12, loops=-1 } )

-----------------------------------------------------------------------------------------
-- GLOBAL VARS
-----------------------------------------------------------------------------------------
hiddenEasterEgg = 0
-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
local function FlyingBallTouch(touch)
    hiddenEasterEgg = 1
    hiddenText.isVisible = true
end

local function MoveApple(event)
    flyingBallX = flyingBallX+2
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

local function SpinMoose(event)
    mooseXscale = mooseXscale + 0.1
    moose:rotate(mooseXscale)
    moose:rotate(mooseXscale)
    moose:rotate(mooseXscale)
end

local function SpinMoose2(event)
    mooseXscale2 = mooseXscale2 + 0.1
    moose2:rotate(mooseXscale2)
    moose2:rotate(mooseXscale2)
    moose2:rotate(mooseXscale2)
end

local function UnMute(touch)
    if (touch.phase == "ended") then
        audio.resume(bkgMusicMM)
        soundOn = true
        muteButton.isVisible = true
        unmuteButton.isVisible = false
    end
end

-- Creating Transitioning Function back to main menu
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "zoomOutInFadeRotate", time = 500})
end

------------------------------------------------------ TRANSITIONS FOR LEVELS --------------------------------------------------------

local function Level1ScreenTransition()
    composer.gotoScene( "level1_screen", {effect = "zoomOutInFadeRotate", time = 500} ) -- change transition if wanted
end

local function Level2ScreenTransition()
    composer.gotoScene( "level2_screen", {effect = "zoomOutInFadeRotate", time = 500} ) -- change transition if wanted
end

local function Level3ScreenTransition()
    composer.gotoScene( "level3_screen", {effect = "zoomOutInFadeRotate", time = 500} ) -- change transition if wanted    
end

local function Level4ScreenTransition()
    composer.gotoScene( "level4_screen", {effect = "zoomOutInFadeRotate", time = 500} ) -- change transition if wanted    
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

    flyingBall = display.newImageRect("Images/ApplesNathan@2x.png", 50, 50)
    flyingBall.x = -500
    flyingBall.y = display.contentHeight/2
    flyingBall.isVisible = true

    hiddenText = display.newText("Congrats You found the hiddenEasterEgg", 0, 0)
    hiddenText.isVisible = false
    hiddenText.x = display.contentWidth/2
    hiddenText.y = 580
    hiddenText:scale(2, 2)
    hiddenText:setTextColor(0, 1, 0)

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()
        level1Button = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*8/17,
            y = display.contentHeight*1/8,

            -- Insert the images here
            defaultFile = "Images/MathLevel1ButtonUnpressedYourName@2x.png",
            overFile = "Images/MathLevel1ButtonPressedYourName@2x.png",

            width =  260, 
            height = 125,

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

        level2Button = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*9/17,
            y = display.contentHeight*3/8,

            -- Insert the images here
            defaultFile = "Images/ArtLevel2ButtonUnpressedYourName@2x.png",
            overFile = "Images/ArtLevel2ButtonPressedYourName@2x.png",

            width =  260, 
            height = 125,

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level2ScreenTransition          
        } )

        level3Button = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*8/17,
            y = display.contentHeight*5/8,

            -- Insert the images here
            defaultFile = "Images/MathLevel3ButtonUnpressedYourName@2x.png",
            overFile = "Images/MathLevel3ButtonPressedYourName@2x.png",

            width =  260, 
            height = 125,

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level3ScreenTransition        
        } )

        level4Button = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*9/17,
            y = display.contentHeight*7/8,

            -- Insert the images here
            defaultFile = "Images/ArtLevel4ButtonUnpressedYourName@2x.png",
            overFile = "Images/ArtLevel4ButtonPressedYourName@2x.png",

            width =  260, 
            height = 125,

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level4ScreenTransition          
        } )

        sceneGroup:insert(level1Button)
        sceneGroup:insert(level2Button)
        sceneGroup:insert(level3Button)  
        sceneGroup:insert(level4Button)
        sceneGroup:insert(flyingBall)
        sceneGroup:insert( muteButton )
        sceneGroup:insert( unmuteButton )
        sceneGroup:insert( hiddenText )
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

    moose = display.newImageRect("Images/MooseCharacterLiamC.png", 200, 200)
    moose.x = display.contentWidth*5/6
    moose.y = display.contentHeight*1/6
    sceneGroup:insert(moose)

    moose2 = display.newImageRect("Images/MooseCharacterLiamC.png", 200, 200)
    moose2.x = display.contentWidth*5/6
    moose2.y = display.contentHeight*5/6
    sceneGroup:insert(moose2)
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
        bkgMusicLevel1Channel = audio.play(bkgMusic)
        muteButton:addEventListener("touch", Mute)
        unmuteButton:addEventListener("touch", UnMute)
        flyingBall:addEventListener("touch", FlyingBallTouch)   
        Runtime:addEventListener("enterFrame", MoveApple)
        Runtime:addEventListener("enterFrame", SpinMoose)
        Runtime:addEventListener("enterFrame", SpinMoose2)
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
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        Runtime:removeEventListener("enterFrame", SpinMoose)
        Runtime:removeEventListener("enterFrame", SpinMoose2)        
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