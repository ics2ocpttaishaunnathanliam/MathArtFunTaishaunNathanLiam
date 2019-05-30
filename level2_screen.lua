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


--Users answer 
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

--answers original x and y
correctAnswerOriginalX = 620
correctAnswerOriginalY = 380

incorrectAnswer1OriginalX = 620
incorrectAnswer1OriginalY = 250

incorrectAnswer2OriginalX = 400
incorrectAnswer2OriginalY = 380

incorrectAnswer3OriginalX = 400
incorrectAnswer3OriginalY = 250

local win

-- timer stuff
local timerText
local clockText
local totalSeconds = 10
local secondsLeft = 10

-- lives
local lives = 5
local heart5
local heart4
local heart3
local heart2
local heart1

-- score
local score = 0

-- wallls
local LeftW
local RightW
local TopW
local BottomW

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

local function YouLoseTransition()
    loseSoundChannel = audio.play(loseSound)
    composer.gotoScene( "you_lose" )
end

local function UpdateTime()
    -- the number of seconds the timer goes by
    secondsLeft = secondsLeft - 1
    -- display the seconds left for the timer
    clockText.text = secondsLeft .. ""
    -- stop timer at 0
    if (secondsLeft <= 0) then
        timer.cancel(countDownTimer)
        lives = 0
        YouLoseTransition()
    end
end

local function WinTransition()
    winSoundChannel = audio.play(winSound)
    composer.gotoScene("level3_screen")
end 

local function startTimer()
    -- start count down timer
    countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end

local function AskQuestion()
    randomAnimalName = math.random(1,3)

    if (randomAnimalName == 1) then
        questionObject.text = "Tiger"
        correctAnswer.text = "Kitten"
        incorrectAnswer1.text = "Pup"
        incorrectAnswer2.text = "Larva"
        incorrectAnswer3.text = "Owlet"
    end

        if (randomAnimalName == 2) then
        questionObject.text = "Goat"
        correctAnswer.text = "Kid"
        incorrectAnswer1.text = "Pup"
        incorrectAnswer2.text = "Piglet"
        incorrectAnswer3.text = "Goaty"
    end
      if (randomAnimalName == 3) then
        questionObject.text = "Mole"
        correctAnswer.text = "Pup"
        incorrectAnswer1.text = "Wellow"
        incorrectAnswer2.text = "Kit"
        incorrectAnswer3.text = "Supole"
    end
end

local function UpdateHearts()
    lives = 5

    if (lives == 4) then
        heart5.isVisible = false
        heart4.isVisible = true
        heart3.isVisible = true
        heart2.isVisible = true
        heart1.isVisible = true
    elseif (lives == 3) then
        heart5.isVisible = false
        heart4.isVisible = false
        heart3.isVisible = true
        heart2.isVisible = true
        heart1.isVisible = true
    elseif (lives == 2) then
        heart5.isVisible = false
        heart4.isVisible = false
        heart3.isVisible = false
        heart2.isVisible = true
        heart1.isVisible = true 
    elseif (lives == 1) then
        heart5.isVisible = false
        heart4.isVisible = false
        heart3.isVisible = false
        heart2.isVisible = false
        heart1.isVisible = true
    elseif (lives == 0) then
        heart5.isVisible = false
        heart4.isVisible = false
        heart3.isVisible = false
        heart2.isVisible = false
        heart1.isVisible = false
        timer.performWithDelay(1000, YouLoseTransition)
    end
end

local function win()
    if ( userAnswer == correctAnswer ) then
        hitSoundChannel = audio.play(hitSound)
        bkgMusicMMChannel = audio.pause(bkgMusicMM)
        timer.performWithDelay(1600, RestartLevel2)
    end   
end

local function RestartLevel2()
    AskQuestion()

    -- set back to original x and y 
    correctAnswer.x = correctAnswerOriginalX
    correctAnswer.y = correctAnswerOriginalY

    -- incorrect 1
    incorrectAnswer1.x = incorrectAnswer1OriginalX
    incorrectAnswer1.y = incorrectAnswer1OriginalY

    -- incorrect 2
    incorrectAnswer2.x = incorrectAnswer2OriginalX
    incorrectAnswer2.y = incorrectAnswer2OriginalY

    -- incorrect 3
    incorrectAnswer3.x = incorrectAnswer3OriginalX
    incorrectAnswer3.y = incorrectAnswer3OriginalY
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



local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", win)
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

local function incorrectAnswer1Listener(touch)


    if (touch.phase == "began") then
        if (correctAnswerAlreadyTouched == false) and (incorrectAnswer2AlreadyTouched == false) 
            and (incorrectAnswer3AlreadyTouched == false) then
            incorrectAnswer1AlreadyTouched = true
        end
    end

    if ( (touch.phase == "moved") and (incorrectAnswer1AlreadyTouched == true) ) then
        incorrectAnswer1.x = touch.x
        incorrectAnswer1.y = touch.y
    end

    if (touch.phase == "ended") then
        correctAnswerAlreadyTouched = false
        incorrectAnswer2AlreadyTouched = false
        incorrectAnswer3AlreadyTouched = false
    end
end

local function incorrectAnswer2Listener(touch)


    if (touch.phase == "began") then
        if (correctAnswerAlreadyTouched == false) and (incorrectAnswer1AlreadyTouched == false) 
            and (incorrectAnswer3AlreadyTouched == false) then
            incorrectAnswer2AlreadyTouched = true
        end
    end

    if ( (touch.phase == "moved") and (incorrectAnswer2AlreadyTouched == true) ) then
        incorrectAnswer2.x = touch.x
        incorrectAnswer2.y = touch.y
    end

    if (touch.phase == "ended") then
        correctAnswerAlreadyTouched = false
        incorrectAnswer1AlreadyTouched = false
        incorrectAnswer3AlreadyTouched = false
    end
end

local function incorrectAnswer3Listener(touch)


    if (touch.phase == "began") then
        if (correctAnswerAlreadyTouched == false) and (incorrectAnswer1AlreadyTouched == false) 
            and (incorrectAnswer2AlreadyTouched == false) then
            incorrectAnswer3AlreadyTouched = true
        end
    end

    if ( (touch.phase == "moved") and (incorrectAnswer3AlreadyTouched == true) ) then
        incorrectAnswer3.x = touch.x
        incorrectAnswer3.y = touch.y
    end

    if (touch.phase == "ended") then
        correctAnswerAlreadyTouched = false
        incorrectAnswer1AlreadyTouched = false
        incorrectAnswer2AlreadyTouched = false
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

                -- pause background music
                bkgMusicMMChannel = audio.pause(bkgMusicMM)
                -- score change
                score = score + 1
                UpdateHearts()
                if (score == 6) then
                    WinTransition()
                end 
                -- play sound
                winSoundChannel = audio.play(winSound)
                -- restart the level after 1.6 seconds
                timer.performWithDelay(1600, RestartLevel2)

            --else make box go back to where it was
            else
                correctAnswer.x = correctAnswerOriginalX
                correctAnswer.y = correctAnswerOriginalY
            end
        end
    end                
end 

local function incorrectAnswer1TouchListener(touch)
    --only work if none of the other boxes have been touched
    if (correctAnswerAlreadyTouched == false) and 
        (incorrectAnswer2AlreadyTouched == false) and
        (incorrectAnswer3AlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            incorrectAnswer1AlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            incorrectAnswer1.x = touch.x
            incorrectAnswer1.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            incorrectAnswer1AlreadyTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < incorrectAnswer1.x ) and
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > incorrectAnswer1.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < incorrectAnswer1.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > incorrectAnswer1.y ) ) then

                -- setting the position of the number to be in the center of the box
                incorrectAnswer1.x = userAnswerBoxPlaceholder.x
                incorrectAnswer1.y = userAnswerBoxPlaceholder.y
                --userAnswer = correctAnswer

                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()
                -- pause background music
                bkgMusicMMChannel = audio.pause(bkgMusicMM)

                -- life is tak3en away for incorrect answer
                lives = lives - 1
                UpdateHearts()
                if (lives == 0) then
                    YouLoseTransition()
                else
                    -- play sound
                    hitSoundChannel = audio.play(hitSound)
                    -- restart the level after 1.6 seconds
                    timer.performWithDelay(1600, RestartLevel2)
                end

            --else make box go back to where it was
            else
                incorrectAnswer1.x = incorrectAnswer1OriginalX
                incorrectAnswer1.y = incorrectAnswer1OriginalY
            end
        end
    end                
end

local function incorrectAnswer2TouchListener(touch)
    --only work if none of the other boxes have been touched
    if (correctAnswerAlreadyTouched == false) and 
        (incorrectAnswer1AlreadyTouched == false) and
        (incorrectAnswer3AlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            incorrectAnswer2AlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            incorrectAnswer2.x = touch.x
            incorrectAnswer2.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            incorrectAnswer2AlreadyTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < incorrectAnswer2.x ) and
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > incorrectAnswer2.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < incorrectAnswer2.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > incorrectAnswer2.y ) ) then

                -- setting the position of the number to be in the center of the box
                incorrectAnswer2.x = userAnswerBoxPlaceholder.x
                incorrectAnswer2.y = userAnswerBoxPlaceholder.y
                --userAnswer = correctAnswer

                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()
                -- pause background music
                bkgMusicMMChannel = audio.pause(bkgMusicMM)

                -- life is tak3en away for incorrect answer
                lives = lives - 1
                UpdateHearts()
                if (lives == 0) then
                    YouLoseTransition()
                else
                    -- play sound
                    hitSoundChannel = audio.play(hitSound)
                    -- restart the level after 1.6 seconds
                    timer.performWithDelay(1600, RestartLevel2)
                end

            --else make box go back to where it was
            else
                incorrectAnswer2.x = incorrectAnswer2OriginalX
                incorrectAnswer2.y = incorrectAnswer2OriginalY
            end
        end
    end                
end

local function incorrectAnswer3TouchListener(touch)
    --only work if none of the other boxes have been touched
    if (correctAnswerAlreadyTouched == false) and 
        (incorrectAnswer1AlreadyTouched == false) and
        (incorrectAnswer2AlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            incorrectAnswer3AlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            incorrectAnswer3.x = touch.x
            incorrectAnswer3.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            incorrectAnswer3AlreadyTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < incorrectAnswer3.x ) and
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > incorrectAnswer3.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < incorrectAnswer3.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > incorrectAnswer3.y ) ) then

                -- setting the position of the number to be in the center of the box
                incorrectAnswer3.x = userAnswerBoxPlaceholder.x
                incorrectAnswer3.y = userAnswerBoxPlaceholder.y
                --userAnswer = correctAnswer

                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()
                -- pause background music
                bkgMusicMMChannel = audio.pause(bkgMusicMM)

                -- life is tak3en away for incorrect answer
                lives = lives - 1
                UpdateHearts()
                if (lives == 0) then
                    YouLoseTransition()
                else
                    -- play sound
                    hitSoundChannel = audio.play(hitSound)
                    -- restart the level after 1.6 seconds
                    timer.performWithDelay(1600, RestartLevel2)
                end

            --else make box go back to where it was
            else
                incorrectAnswer3.x = incorrectAnswer3OriginalX
                incorrectAnswer3.y = incorrectAnswer3OriginalY
            end
        end
    end                
end


local function AddTouchListeners()
    correctAnswer:addEventListener("touch", correctAnswerListener)
    correctAnswer:addEventListener("touch", TouchListenerCorrectAnswer)
    incorrectAnswer1:addEventListener("touch", incorrectAnswer1Listener)
    incorrectAnswer1:addEventListener("touch", incorrectAnswer1TouchListener)
    incorrectAnswer2:addEventListener("touch", incorrectAnswer2Listener)
    incorrectAnswer2:addEventListener("touch", incorrectAnswer2TouchListener)
    incorrectAnswer3:addEventListener("touch", incorrectAnswer3Listener)
    incorrectAnswer3:addEventListener("touch", incorrectAnswer3TouchListener)
    unmuteButton:addEventListener("touch", UnMute)
    muteButton:addEventListener("touch", Mute)
end

local function RemoveTouchListeners()
    correctAnswer:removeEventListener("touch", correctAnswerListener)
    correctAnswer:removeEventListener("touch", TouchListenerCorrectAnswer)
    incorrectAnswer1:removeEventListener("touch", incorrectAnswer1Listener)
    incorrectAnswer1:removeEventListener("touch", incorrectAnswer1TouchListener)
    incorrectAnswer2:removeEventListener("touch", incorrectAnswer2Listener)
    incorrectAnswer2:removeEventListener("touch", incorrectAnswer2TouchListener)
    incorrectAnswer3:removeEventListener("touch", incorrectAnswer3Listener)
    incorrectAnswer3:removeEventListener("touch", incorrectAnswer3TouchListener)
    unmuteButton:removeEventListener("touch", UnMute)
    muteButton:removeEventListener("touch", Mute)
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
    titleQuestionObject.isVisible = false

    -- text object
    questionObject = display.newText( "", 408, 490, nil, 55 )
    questionObject:setTextColor(0.8, 0.5, 0.3)

    -- text object
    correctAnswer = display.newText( "", 620, 380, nil, 50 )
    correctAnswer:setTextColor(0.8, 0.2, 0.5)

    --text object 2
    incorrectAnswer1 = display.newText( "", 620, 250, nil, 50)
    incorrectAnswer1 :setTextColor(0.8, 0.2, 0.5)

    -- text object 3
    incorrectAnswer2  = display.newText( "", 400, 380, nil, 50 )
    incorrectAnswer2:setTextColor(0.8, 0.2, 0.5)

    -- text object 4
    incorrectAnswer3  = display.newText( "", 400, 250, nil, 50)
    incorrectAnswer3:setTextColor(0.8, 0.2, 0.5)

    -- displays text for timer
    timerText = display.newText( "Timer", 680, 670, nil, 55)

    -- displays actual time for timer
    clockText = display.newText( "", 680, 735, nil, 55)

    --WALLS--

    LeftW = display.newLine( 0, 0, 0, display.contentHeight)
    LeftW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene

    RightW = display.newLine( 1024, 0, 1024, display.contentHeight)
    RightW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene   

    TopW = display.newLine( 0, 0, display.contentWidth, 0)
    TopW.isVisible = true

    -- hearts
    heart1 = display.newImageRect("Images/heart@2x.png", 75, 75)
    heart1.x = display.contentWidth * 0.5 / 10
    heart1.y = display.contentHeight * 9.5 / 10

    heart2 = display.newImageRect("Images/heart@2x.png", 75, 75)
    heart2.x = display.contentWidth * 1.5 / 10
    heart2.y = display.contentHeight * 9.5 / 10

    heart3 = display.newImageRect("Images/heart@2x.png", 75, 75)
    heart3.x = display.contentWidth * 2.5 / 10
    heart3.y = display.contentHeight * 9.5 / 10

    heart4 = display.newImageRect("Images/heart@2x.png", 75, 75)
    heart4.x = display.contentWidth * 3.5 / 10
    heart4.y = display.contentHeight * 9.5 / 10

    heart5 = display.newImageRect("Images/heart@2x.png", 75, 75)
    heart5.x = display.contentWidth * 4.5 / 10
    heart5.y = display.contentHeight * 9.5 / 10

    muteButton = display.newImageRect("Images/Mute.png", 175, 175)
    muteButton.x = display.contentWidth * 1 / 10
    muteButton.y = display.contentHeight * 1 / 10 

    unmuteButton = display.newImageRect("Images/UnMute.png", 175, 175)
    unmuteButton.x = display.contentWidth * 1 / 10
    unmuteButton.y = display.contentHeight * 1 / 10 

    -- the black box where the user will drag the answer
    userAnswerBoxPlaceholder = display.newImageRect("Images/userAnswerBoxPlaceholder.png",  130, 130, 0, 0)
    userAnswerBoxPlaceholder.x = display.contentWidth * 0.58
    userAnswerBoxPlaceholder.y = display.contentHeight * 0.64
    userAnswerBoxPlaceholder.width = 200
    userAnswerBoxPlaceholder.height = 100
    userAnswerBoxPlaceholder.isVisible = false

    -- scene groups
    sceneGroup:insert( titleQuestionObject )
    sceneGroup:insert( questionObject )
    sceneGroup:insert( correctAnswer )
    sceneGroup:insert( incorrectAnswer1 )
    sceneGroup:insert( incorrectAnswer2 )
    sceneGroup:insert( incorrectAnswer3 )
    sceneGroup:insert( userAnswerBoxPlaceholder )
    sceneGroup:insert( timerText )
    sceneGroup:insert( clockText )
    sceneGroup:insert( LeftW )
    sceneGroup:insert( RightW )
    sceneGroup:insert( TopW )
    sceneGroup:insert( heart1 )
    sceneGroup:insert( heart2 )
    sceneGroup:insert( heart3 )
    sceneGroup:insert( heart4 )
    sceneGroup:insert( heart5 )
    sceneGroup:insert( unmuteButton )
    sceneGroup:insert( muteButton )
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

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc
        secondsLeft = totalSeconds
        lives = 5
        score = 0
        UpdateHearts()
        AskQuestion()
        AddTouchListeners()
        AddRuntimeListeners()
        startTimer()
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
