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
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local randomAnimalName

-- The local variables for this scene
local bkg_image

local score = 0
local lives = 5

-- text objects
local titleQuestionObject

local questionObject
local correctAnswer
local incorrectAnswer1
local incorrectAnswer2
local incorrectAnswer3

local correctAnswerAlreadyTouched = false
local incorrectAnswer1AlreadyTouched = false
local incorrectAnswer2AlreadyTouched = false
local incorrectAnswer3AlreadyTouched = false


--Users answer 
local userAnswer

-- the answer box where the user puts his or her answer
local userAnswerBoxPlaceholder

--sound
local muteButton
local unmuteButton


local bkgMusicMM = audio.loadStream("Sounds/mmBKGmusic.mp3")
local bkgMusicMMChannel = audio.play( bkgMusicMM, { channel=1, loops=-1 } )

--answers original x and y
local Y1 = 380
local Y2 = 250
local X1 = 620
local X2 = 400

local correctAnswerOriginalX = X1
local correctAnswerOriginalY = Y1

local incorrectAnswer1OriginalX = X1
local incorrectAnswer1OriginalY = Y2

local incorrectAnswer2OriginalX = X2
local incorrectAnswer2OriginalY = Y1

local incorrectAnswer3OriginalX = X2
local incorrectAnswer3OriginalY = Y2

-- timer stuff
local timerText
local clockText
local totalSeconds = 45
local secondsLeft = 45

-- lives
local heart5
local heart4
local heart3
local heart2
local heart1

-- score
local score = 0
local scoreText
local scoreTitle

-- wallls
local LeftW
local RightW
local TopW
local BottomW

-- randomizing answers
local randomAnswer

-- rectangle
local rectangle
local vertices1 = { 320,115, 320,10, 780,10, 780,115 }

local myGroup = display.newGroup()

local backButton

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
        lives = 0
        YouLoseTransition()
    end
end

--
local function WinTransition()
    winSoundChannel = audio.play(winSound)
    composer.gotoScene("level3_screen")
end 


local function startTimer()
    -- start count down timer
    countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end

-- Creating Transitioning Function back to main menu
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "zoomOutInFadeRotate", time = 500})
    bkgMusicMMChannel = audio.pause(bkgMusicMM)
end

local function AskQuestion()
    randomAnimalName = math.random(1,12)

    if (randomAnimalName == 1) then
        questionObject.text = "Tiger"
        correctAnswer.text = "Kitten"
        incorrectAnswer1.text = "Pup"
        incorrectAnswer2.text = "Larva"
        incorrectAnswer3.text = "Owlet"

    elseif (randomAnimalName == 2) then
        questionObject.text = "Goat"
        correctAnswer.text = "Kid"
        incorrectAnswer1.text = "Pup"
        incorrectAnswer2.text = "Piglet"
        incorrectAnswer3.text = "Goaty"

    elseif (randomAnimalName == 3) then
        questionObject.text = "Mole"
        correctAnswer.text = "Pup"
        incorrectAnswer1.text = "Wellow"
        incorrectAnswer2.text = "Kit"
        incorrectAnswer3.text = "Supole"

    elseif (randomAnimalName == 4) then
        questionObject.text = "Bat"
        correctAnswer.text = "Pup"
        incorrectAnswer1.text = "Infant"
        incorrectAnswer2.text = "Wriggler"
        incorrectAnswer3.text = "Pluteus"

    elseif (randomAnimalName == 5) then
        questionObject.text = "Shark"
        correctAnswer.text = "Pup"
        incorrectAnswer1.text = "Sharkling"
        incorrectAnswer2.text = "Sharkster"
        incorrectAnswer3.text = "Smolt"

    elseif (randomAnimalName == 6) then
        questionObject.text = "Cod"
        correctAnswer.text = "Codling"
        incorrectAnswer1.text = "Eft"
        incorrectAnswer2.text = "Whelp"
        incorrectAnswer3.text = "Calf"

    elseif (randomAnimalName == 7) then
        questionObject.text = "Aardvark"
        correctAnswer.text = "Cub"
        incorrectAnswer1.text = "Pup"
        incorrectAnswer2.text = "Varky"
        incorrectAnswer3.text = "Puggle"

    elseif (randomAnimalName == 8) then
        questionObject.text = "Monkey"
        correctAnswer.text = "Infant"
        incorrectAnswer1.text = "Ape"
        incorrectAnswer2.text = "Pup"
        incorrectAnswer3.text = "Munk"

    elseif (randomAnimalName == 9) then
        questionObject.text = "Wolf"
        correctAnswer.text = "Cub"
        incorrectAnswer1.text = "Wolves"
        incorrectAnswer2.text = "Kitten"
        incorrectAnswer3.text = "Fawn"

    elseif (randomAnimalName == 10) then
        questionObject.text = "Sheep"
        correctAnswer.text = "Lamb"
        incorrectAnswer1.text = "Sheepling"
        incorrectAnswer2.text = "Pup"
        incorrectAnswer3.text = "Snoop"

    elseif (randomAnimalName == 11) then
        questionObject.text = "Crow"
        correctAnswer.text = "Chick"
        incorrectAnswer1.text = "Fawn"
        incorrectAnswer2.text = "Squab"
        incorrectAnswer3.text = "Duckling"

    elseif (randomAnimalName == 12) then
        questionObject.text = "Elephant"
        correctAnswer.text = "Calf"
        incorrectAnswer1.text = "Kid"
        incorrectAnswer2.text = "Billy"
        incorrectAnswer3.text = "Eyas"
    end
end

local function UpdateHearts()
    if (lives == 5) then
        heart5.isVisible = true
        heart4.isVisible = true
        heart3.isVisible = true
        heart2.isVisible = true
        heart1.isVisible = true

    elseif (lives == 4) then
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

local function PositionAnswers()

    --creating random start position in a cretain area
    answerPosition = math.random(1,4)

    if (answerPosition == 1) then

        correctAnswer.x = X2
        correctAnswer.y = Y2        
        
        incorrectAnswer1.x = X2
        incorrectAnswer1.y = Y1
        
        incorrectAnswer2.x = X1
        incorrectAnswer2.y = Y2

        incorrectAnswer3.x = X1
        incorrectAnswer3.y = Y1

        
    elseif (answerPosition == 2) then

        correctAnswer.x = X2
        correctAnswer.y = Y1
            
        incorrectAnswer1.x = X1
        incorrectAnswer1.y = Y1
            
        incorrectAnswer2.x = X2
        incorrectAnswer2.y = Y2

        incorrectAnswer3.x = X1
        incorrectAnswer3.y = Y2


    elseif (answerPosition == 3) then

        correctAnswer.x = X1
        correctAnswer.y = Y2
            
        incorrectAnswer1.x = X2
        incorrectAnswer1.y = Y2
            
        incorrectAnswer2.x = X1
        incorrectAnswer2.y = Y1

        incorrectAnswer3.x = X2
        incorrectAnswer3.y = Y1

    elseif (answerPosition == 4) then

        correctAnswer.x = X2
        correctAnswer.y = Y1
            
        incorrectAnswer1.x = X1
        incorrectAnswer1.y = Y2
            
        incorrectAnswer2.x = X2
        incorrectAnswer2.y = Y2

        incorrectAnswer3.x = X1
        incorrectAnswer3.y = Y1
    end

    -- remember all the original positions
    correctAnswerOriginalX = correctAnswer.x
    correctAnswerOriginalY = correctAnswer.y
    -- incorrect 1
    incorrectAnswer1OriginalX = incorrectAnswer1.x
    incorrectAnswer1OriginalY = incorrectAnswer1.y
    --incorrect 2
    incorrectAnswer2OriginalX = incorrectAnswer2.x
    incorrectAnswer2OriginalY = incorrectAnswer2.y
    --incorrect 3
    incorrectAnswer3OriginalX = incorrectAnswer3.x
    incorrectAnswer3OriginalY = incorrectAnswer3.y
end

local function RestartLevel2()
    AskQuestion()
    PositionAnswers()
    bkgMusicMMChannel = audio.resume(bkgMusicMM)
end


local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", win)
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


                -- pause background music
                bkgMusicMMChannel = audio.pause(bkgMusicMM)
                -- play sound
                winSoundChannel = audio.play(winSound)

                -- score change
                score = score + 1
                scoreText.text = score .. "/6"
                if (score == 6) then
                    WinTransition()
                else 
                    -- restart the level after 1.6 seconds
                    timer.performWithDelay(1600, RestartLevel2)
                end 
            -- if they release the textbox before the answerbox, then return it to its original position
            else                 
                -- setting the position of the number to be in the center of the box
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
    correctAnswer:addEventListener("touch", TouchListenerCorrectAnswer)
    incorrectAnswer1:addEventListener("touch", incorrectAnswer1TouchListener)
    incorrectAnswer2:addEventListener("touch", incorrectAnswer2TouchListener)
    incorrectAnswer3:addEventListener("touch", incorrectAnswer3TouchListener)
    unmuteButton:addEventListener("touch", UnMute)
    muteButton:addEventListener("touch", Mute)
end

local function RemoveTouchListeners()
    correctAnswer:removeEventListener("touch", TouchListenerCorrectAnswer)
    incorrectAnswer1:removeEventListener("touch", incorrectAnswer1TouchListener)
    incorrectAnswer2:removeEventListener("touch", incorrectAnswer2Listener)
    incorrectAnswer2:removeEventListener("touch", incorrectAnswer2TouchListener)
    incorrectAnswer3:removeEventListener("touch", incorrectAnswer3Listener)
    incorrectAnswer3:removeEventListener("touch", incorrectAnswer3TouchListener)
    unmuteButton:removeEventListener("touch", UnMute)
    muteButton:removeEventListener("touch", Mute)
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

    -- questin text above
    titleQuestionObject = display.newText( "Match animal baby names\n      to their adult ones!", 505, 93, nil, 35 )
    titleQuestionObject:setTextColor(0, 0, 0)
    titleQuestionObject.isVisible = true

    -- text object
    questionObject = display.newText( "", 390, 490, nil, 55 )
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
    userAnswerBoxPlaceholder = display.newImageRect("Images/userAnswerBoxPlaceholder.png",  200, 100)
    userAnswerBoxPlaceholder.x = display.contentWidth * 0.585
    userAnswerBoxPlaceholder.y = display.contentHeight * 0.64
    userAnswerBoxPlaceholder.isVisible = false

    --rectangle
    rectangle = display.newPolygon( 505, 95, vertices1)
    --set fill colour
    rectangle:setFillColor(255/255, 153/255, 153/255)
    -- set stroke width
    rectangle.strokeWidth = 5
    --set colour of the border
    rectangle:setStrokeColor(1, 0, 0)
    rectangle.isVisible = true

    --score text
    scoreText = display.newText( score .. "/6", 930, 375, nil, 45)
    scoreText:setTextColor(1, 0.3, 0.3)

    scoreTitle = display.newText( "Score =", 922, 320, nil, 50)
    scoreTitle:setTextColor(0.1, 0.3, 0.7)

    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*7.2/8,
        y = display.contentHeight*1/16,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressedYourName@2x.png",
        overFile = "Images/BackButtonPressedYourName@2x.png",

        width = 185,
        height = 75,

        -- Setting Functional Properties
        onRelease = BackTransition

    } )

    -- scene groups
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( rectangle )
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
    sceneGroup:insert( scoreText )
    sceneGroup:insert( scoreTitle )
    sceneGroup:insert( backButton )
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
        PositionAnswers()
        AskQuestion()
        AddTouchListeners()
        AddRuntimeListeners()
        startTimer()
        bkgMusicMMChannel = audio.play(bkgMusicMM)
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
        timer.cancel(countDownTimer)
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
