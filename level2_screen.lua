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
sceneName = "level2_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local randomAnimalName
local elephant = 1
local swan = 2
local koalas = 3
local turtle = 4
local fish = 5
local goat = 6
local narwhal = 7
local cow = 8
local fox = 9
local tiger = 10

-- The local variables for this scene
local bkg_image

local score = 0

-- text objects
local titleQuestionObject

local questionObject
local correctAnswer
local incorrectAnswer1
local incorrectAnswer2
local incorrectAnswer3

local userAnswerBoxPlaceholder

local correctAnswerAlreadyTouched = false
local incorrectAnswer1AlreadyTouched = false
local incorrectAnswer2AlreadyTouched = false
local incorrectAnswer3AlreadyTouched = false

local correctAnswerOriginalX
local incorrectAnswer1OriginalX
local incorrectAnswer2OriginalX
local incorrectAnswer3OriginalX

local correctAnswerOriginalY
local incorrectAnswer1OriginalY
local incorrectAnswer2OriginalY
local incorrectAnswer3OriginalY

-- correct and alternate answers
local correctAnswer
local alternateAnswer1
local alternateAnswer2
local alternateAnswer3


--Users answer and actual answer
local userAnswer

-- boolean variables that tell me which answer box was touched 
local answerBoxAlreadyTouched = false
local alternateAnswerBox1AlreadyTouched = false
local alternateAnswerBox2ALreadyTouched = false
local alternateAnswerBox3AlreadyTouched = false


--create text boxes that hold answers and alternate answers
local answerBox
local alternateAnswerBox1
local alternateAnswerBox2
local alternateAnswerBox3

--create variables that will hold the previous x and y positions so --
-- that they will return back to its previous position after
local answerBoxPreviousY
local AlternateAnswerBox1PreviousY
local AlternateAnswerBox2PreviousY
local AlternateAnswerBox3PreviousY


-- and x position
local answerBoxPreviousX
local AlternateAnswerBox1PreviousX
local AlternateAnswerBox2PreviousX
local AlternateAnswerBox3PreviousX


-- the answer box where the user puts his or her answer
local userAnswerBoxPlaceholder

--sound
local muteButton
local unmuteButton

local bkgMusicMM = audio.loadStream("Sounds/mmBKGmusic.mp3")
local bkgMusicMMChannel = audio.play( bkgMusicMM, { channel=1, loops=-1 } )

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

local function AskQuestion()
    randomAnimalName = math.random(1,1)

    if (randomAnimalName == 1) then
        questionObject.text = "Tiger"
        correctAnswer.text = "Kitten"
        incorrectAnswer1.text = "Pup"
        incorrectAnswer2.text = "Larva"
        incorrectAnswer3.text = "Owlet"
    end
end

local function RandomlyPositionAnswers()

end

local function DisplayingQuestion()

    --set random question 
    randomAnimalName = math.random(1, 1)

    --set correct answer to equal the number of the question
    --correctAnswer = randomAnimalName

    -- put the correct answer in the answer box
    --answerBox.text = correctAnswer

    -- make possible to click on answers again
    answerBoxAlreadyTouched = false
    alternateAnswerBox1AlreadyTouched = false
    alternateAnswerBox2ALreadyTouched = false
    alternateAnswerBox3AlreadyTouched = false
end


local function DeterminingAlternateAnswers()
    -- generate incorrect answers and set them to a text box
    alternateAnswer1 = randomAnimalName + 2
    alternateAnswerBox1.text = alternateAnswer1
end

local function YouLoseTransition()
    loseSoundChannel = audio.play(loseSound)
    composer.gotoScene( "you_lose" )
end

local function correctAnswerListener(touch)

    -- play sound
    --touchedSoundChannel = audio.play(touchedSound)

    if (touch.phase == "began") then
        if (incorrectAnswer1AlreadyTouched == false) and (incorrectAnswer2AlreadyTouched == false) 
            and (incorrectAnswer3AlreadyTouched == false) then
            correctAnswerAlreadyTouched = true
        end
    end

    if ( (touch.phase == "moved") and (correctAnswerAlreadyTouched == true) ) then
        correctAnswer.x = touch.x
        correctAnswer.y = touch.y
    end

    if (touch.phase == "ended") then
        incorrectAnswer1AlreadyTouched= false
        incorrectAnswer2AlreadyTouched = false
        incorrectAnswer3AlreadyTouched = false
    end
end

local function TouchListenerCorrectAnswer(touch)
    --only work if none of the other boxes have been touched
    if (incorrectAnswer1AlreadyTouched == false) and 
        (incorrectAnswer2AlreadyTouched == false) and
        (incorrectAnswer3AlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            correctAnswerAlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            correctAnswer.x = touch.x
            correctAnswer.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            correctAnswerAlreadyTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < correctAnswer.x ) and
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > correctAnswer.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < correctAnswer.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > correctAnswer.y ) ) then

                -- setting the position of the number to be in the center of the box
                correctAnswer.x = userAnswerBoxPlaceholder.x
                correctAnswer.y = userAnswerBoxPlaceholder.y
                --userAnswer = correctAnswer

                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            else
                correctAnswer.x = correctAnswerOriginalX
                correctAnswer.y = correctAnswerOriginalY
            end
        end
    end                
end 


local function AddTouchListeners()
    correctAnswer:addEventListener("touch", correctAnswerListener)
end

local function RemoveTouchListeners()
    correctAnswer:removeEventListener("touch", correctAnswerListener)
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
    
    -- questin text above
    titleQuestionObject = display.newText( "Match animal baby names\nto their adult ones!", 518, 610, nil, 50 )
    titleQuestionObject:setTextColor(1, 0, 0)

    -- text object
    questionObject = display.newText( "", 408, 495, nil, 50 )
    questionObject:setTextColor(0.8, 0.5, 0.3)

    -- text object
    correctAnswer = display.newText( "", 620, 400, nil, 50 )
    correctAnswer:setTextColor(0.8, 0.2, 0.5)

    --text object 2
    incorrectAnswer1 = display.newText( "", 620, 250, nil, 50)
    incorrectAnswer1 :setTextColor(0.8, 0.2, 0.5)

    -- text object 3
    incorrectAnswer2  = display.newText( "", 400, 400, nil, 50 )
    incorrectAnswer2 :setTextColor(0.8, 0.2, 0.5)

    -- text object 4
    incorrectAnswer3  = display.newText( "", 400, 250, nil, 50)
    incorrectAnswer3 :setTextColor(0.8, 0.2, 0.5)

    -- the black box where the user will drag the answer
    userAnswerBoxPlaceholder = display.newImageRect("Images/userAnswerBoxPlaceholder.png",  130, 130, 0, 0)
    userAnswerBoxPlaceholder.x = display.contentWidth * 0.6
    userAnswerBoxPlaceholder.y = display.contentHeight * 0.6
    userAnswerBoxPlaceholder.width = 200
    userAnswerBoxPlaceholder.height = 100

    sceneGroup:insert( titleQuestionObject )
    sceneGroup:insert( questionObject )
    sceneGroup
end 
    

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
        AskQuestion()
        AddTouchListeners()
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
        RemoveTouchListeners()
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
