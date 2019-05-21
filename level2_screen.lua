-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Title: SSG (SuperSlamGames)
-- Name: Liam Csiffary
-- Course: ICS2O/3C
-- This program is the level 1 screen of the program it is where the user starts to play the game.

-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local elephant = 1
local swan = 2
local koalas = 3
local turtle = 4
local fish = 5
local goat = 6
local narwhal = 7

-- The local variables for this scene
local bkg_image

local score = 0

-- correct and alternate answers
local correctAnswer
local alternateAnswer1
local alternateAnswer2
local alternateAnswer3
local alternateAnswer4
local alternateAnswer5
local alternateAnswer6
local alternateAnswer7
local alternateAnswer8
local alternateAnswer9

--Users answer and actual answer
local userAnswer

-- boolean variables that tell me which answer box was touched 
local answerBoxAlreadyTouched = false
local alternateAnswerBox1readyTouched = false
local alternateAnswerBox2readyTouched = false
local alternateAnswerBox3readyTouched = false
local alternateAnswerBox4readyTouched = false
local alternateAnswerBox5readyTouched = false
local alternateAnswerBox6readyTouched = false
local alternateAnswerBox7readyTouched = false
local alternateAnswerBox8readyTouched = false
local alternateAnswerBox9readyTouched = false

--create text boxes that hold answers and alternate answers
local answerBox
local alternateAnswerBox1
local alternateAnswerBox2
local alternateAnswerBox3
local alternateAnswerBox4
local alternateAnswerBox5
local alternateAnswerBox6
local alternateAnswerBox7
local alternateAnswerBox8
local alternateAnswerBox9

--create variables that will hold the previous x and y positions so --
-- that they will return back to its previous position after
local answerBoxPreviousY
local AlternateAnswerBox1PreviousY
local AlternateAnswerBox2PreviousY
local AlternateAnswerBox3PreviousY
local AlternateAnswerBox4PreviousY
local AlternateAnswerBox5PreviousY
local AlternateAnswerBox6PreviousY
local AlternateAnswerBox7PreviousX
local AlternateAnswerBox8PreviousX
local AlternateAnswerBox9PreviousX

-- and x position
local answerBoxPreviousX
local AlternateAnswerBox1PreviousX
local AlternateAnswerBox2PreviousX
local AlternateAnswerBox3PreviousX
local AlternateAnswerBox4PreviousX
local AlternateAnswerBox5PreviousX
local AlternateAnswerBox6PreviousX
local AlternateAnswerBox7PreviousX
local AlternateAnswerBox8PreviousX
local AlternateAnswerBox9PreviousX

-- the answer box where the user puts his or her answer
local userAnswerBoxPlaceholder
-----------------------------------------------------------------------------------------
-- SOUND VARIABLES
----------------------------------------------------------------------------------------- 

local loseSound = audio.loadSound( "Sounds/YouLose.mp3" )
local loseSoundChannel

local hitSound = audio.loadSound( "Sounds/Pop.mp3" )
local hitSoundChannel

local winSound = audio.loadSound( "Sounds/Cheer.m4a" )
local winSoundChannel

----------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
------------------------------------------------------------------- 
local function DisplayingQuestion()
    local randomAnimalName

    --set random anwser
    randomAnimalName = math.random(1, 10)

    -- correct answer
    correctAnswer = randomAnimalName = randomBabyName



local function YouLoseTransition()
    loseSoundChannel = audio.play(loseSound)
    composer.gotoScene( "you_lose" )
end

local function onCollision( self, event )
    -- for testing purposes
    --print( event.target )        --the first object in the collision
    --print( event.other )         --the second object in the collision
    --print( event.selfElement )   --the element (number) of the first object which was hit in the collision
    --print( event.otherElement )  --the element (number) of the second object which was hit in the collision
    --print( event.target.myName .. ": collision began with " .. event.other.myName )
    if ( event.phase == "began" ) then
    end    
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------


-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level2ScreenNathan@2x.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

        -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )     
end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------
        physics.start()

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

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
