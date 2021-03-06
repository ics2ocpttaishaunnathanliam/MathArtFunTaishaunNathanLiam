-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Title: SSG (SuperSlamGames)
-- Name: Liam Csiffary
-- Course: ICS2O/3C
-- This program is the level 1 screen of the program it is where the user starts to play the game.

-----------------------------------------------------------------------------------------
--
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

-- The local variables for this scene
local bkg_image

-- back button var
local backButton

local character

-- create apples
local apple1
local apple2
local apple3
local apple4
local apple5
local apple6
-- so you can retreive the apple you touched
local theApple

-- all the varws required to move the moose
local motionx = 0
local motiony = 0
local SPEED = 6
local SPEEDR = -6
local LINEAR_VELOCITY = -100
local GRAVITY = 4

-- the arrows you touch to move the moose
local rArrow
local lArrow
local uArrow
local dArrow

-- the life vars (hearts, and number of lives)
local numLives = 3
local heart1
local heart2
local heart3

-- walls thqat stop the moose from escaping the arena
local leftW 
local rightW
local topW
local floor
local appleW

-- door to next level
local door

-- direcrter arrows
local pointerArrow
local pointerArrow2
local pointerArrow3
local pointerArrow4
local pointerArrow5

-- to delete the arrows
local theArrow


-- timer vars
local totalSeconds = 45
local secondsLeft = 45
local clockText
local countDownTimer

-- easter egg vars
local flyingBall
local flyingBallX = 400
local hiddenText

-----------------------------------------------------------------------------------------
-- SOUND VARIABLES
----------------------------------------------------------------------------------------- 
-- sound whne you go to the "you lose screen"
local loseSound = audio.loadSound( "Sounds/YouLose.mp3" )
local loseSoundChannel

-- hit sound when you loose a life
local hitSound = audio.loadSound( "Sounds/Pop.mp3" )
local hitSoundChannel

-- when you get an answer right
local winSound = audio.loadSound( "Sounds/Cheer.m4a" )
local winSoundChannel

-- background sound
local bkgMusicLevel1 = audio.loadSound("Sounds/level1Music.mp3")

----------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
----------------------------------------------------------------------
-- bring to you to "you lose screen" when called
local function FlyingBallTouch(touch)
    hiddenEasterEgg3 = 1
    hiddenText.isVisible = true
end

local function YouLoseTransition()
    composer.gotoScene( "you_lose" )
end

-- when right arrow is touched move right
local function right (touch)
    motionx = SPEED
    character.xScale = 1
end

-- when right arrow is touched move right
local function left (touch)
    motionx = -SPEED
    character.xScale = -1
end

-- when right arrow is touched move right
local function up (touch)
    motiony = -SPEED
end
-- moves the player when called
local function movePlayer (event)
    character.x = character.x + motionx
    character.y = character.y + motiony
end

-- stops th emovement of the player when called
local function stop (event)
    if (event.phase == "ended") then
        motionx = 0
        motiony = 0
    end
end

-- brings you to the "mainMenu screen" when called
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "zoomOutInFadeRotate", time = 500})
end

-- adds the touch listeners to the arrows
local function AddArrowEventListeners()
    rArrow:addEventListener("touch", right)
    lArrow:addEventListener("touch", left)
    uArrow:addEventListener("touch", up)
end

-- removes the touch listeners to the arrows
local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    lArrow:removeEventListener("touch", left)
    uArrow:removeEventListener("touch", up)
end

-- changes the number of lives if the numLives goes down
local function checkLives(event)
    if (numLives == 2) then
        heart1.isVisible = true
        heart2.isVisible = true
        heart3.isVisible = false

    elseif (numLives == 1) then
        -- update hearts
        heart1.isVisible = true
        heart2.isVisible = false
        heart3.isVisible = false

    elseif (numLives == 0) then
        -- update hearts
        heart1.isVisible = false
        heart2.isVisible = false
        heart3.isVisible = false
        numLives = 3
        timer.cancel(countDownTimer)
        timer.performWithDelay(200, YouLoseTransition)
    end
end

-- mute button dissapears when touched and stops the sound
local function Mute(touch)
    if (touch.phase == "ended") then
        audio.pause(bkgMusicMM)
        soundOn = false
        muteButton.isVisible = false
        unmuteButton.isVisible = true
    end
end

-- unmute button dissapears and starts sound when touched
local function UnMute(touch)
    if (touch.phase == "ended") then
        audio.resume(bkgMusicMM)
        soundOn = true
        muteButton.isVisible = true
        unmuteButton.isVisible = false
    end
end

-- adds runtime listerners to certain functions
local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", checkLives)
    Runtime:addEventListener("enterFrame", movePlayer)
    Runtime:addEventListener("touch", stop)
end

-- removes runtime listerners to certain functions
local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", movePlayer)
    Runtime:removeEventListener("enterFrame", checkLives)
    Runtime:removeEventListener("touch", stop)
end

-- replaces character function and the character itself after you answer a question
local function ReplaceCharacter()
    character = display.newImageRect("Images/MooseCharacterLiamC.png", 100, 150)
    character.x = display.contentWidth * 1 / 8
    character.y = display.contentHeight  * 2.5 / 3
    character.width = 240
    character.height = 160
    character.myName = "Moose"

    -- intialize horizontal movement of character
    motionx = 0

    -- add physics body
    physics.addBody( character, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )

    -- prevent character from being able to tip over
    character.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end
-- same a replace character 1 but changes the look of the character 
local function ReplaceCharacter2()
    character = display.newImageRect("Images/Moose2.png", 100, 150)
    character.x = display.contentWidth * 1 / 8
    character.y = display.contentHeight  * 2.5 / 3
    character.width = 240
    character.height = 160
    character.myName = "Moose"

    -- intialize horizontal movement of character
    motionx = 0

    -- add physics body
    physics.addBody( character, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )

    -- prevent character from being able to tip over
    character.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end

-- same a replace character 1 but changes the look of the character 
local function ReplaceCharacter3()
    character = display.newImageRect("Images/Moose3.png", 100, 150)
    character.x = display.contentWidth * 1 / 8
    character.y = display.contentHeight  * 2.5 / 3
    character.width = 240
    character.height = 160
    character.myName = "Moose"

    -- intialize horizontal movement of character
    motionx = 0

    -- add physics body
    physics.addBody( character, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )

    -- prevent character from being able to tip over
    character.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end

-- same a replace character 1 but changes the look of the character 
local function ReplaceCharacter4()
    character = display.newImageRect("Images/Moose4.png", 100, 150)
    character.x = display.contentWidth * 1 / 8
    character.y = display.contentHeight  * 2.5 / 3
    character.width = 240
    character.height = 160
    character.myName = "Moose"

    -- intialize horizontal movement of character
    motionx = 0

    -- add physics body
    physics.addBody( character, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )

    -- prevent character from being able to tip over
    character.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end

-- so as to not have missing objects when resetiong the level
local function MakeAppleVisible()
    apple1.isVisible = true
    apple2.isVisible = true
    apple3.isVisible = true
    apple4.isVisible = true
    apple5.isVisible = true
end
-- same as "MakeAppleVisible"
local function MakeHeartsVisible()
    heart1.isVisible = true
    heart2.isVisible = true
end

-- adds transitions to buttons
local transitionOptions_SlideDown = (
    {
        effect = "slideDown", -- The animation it's going to use when transitioning
        time = 1000, -- How long the transition will take
    })

-- The function which transitions to the next screen
function Transition_SlideDown( )
    composer.gotoScene( "you_lose", transitionOptions_SlideDown )
end 

-- updates the timer to display 1 less second
local function UpdateTime()

    -- decrement the number of seconds
    secondsLeft = secondsLeft - 1
    
    -- display the number of seconds left in the clock object
    clockText.text = "Seconds left = " .. secondsLeft .. ""

    if (secondsLeft == 0 ) then
        -- you lose transition when out of time
        YouLoseTransition() 
        secondsLeft = totalSeconds
    end

end

-- resets timer 
local function stopDieTimer()
    secondsLeft = totalSeconds
end

-- these functions delete the pointerArrows when touched by the character, I was angry when i named them
local function Die()
    physics.removeBody(pointerArrow)
    pointerArrow.isVisible = false
end

local function Die2()
    physics.removeBody(pointerArrow2)
    pointerArrow2.isVisible = false
end

local function Die3()
    physics.removeBody(pointerArrow3)
    pointerArrow3.isVisible = false
end

local function Die4()
    physics.removeBody(pointerArrow4)
    pointerArrow4.isVisible = false
end

local function Die5()
    physics.removeBody(pointerArrow5)
    pointerArrow5.isVisible = false
end

-- deletes apple wall
local function RemoveWallPhysics()
    physics.removeBody(appleW)
end

-- changes the outfit of you character
local function CharacterSelect()
    if (characterNumber == 1) then
        ReplaceCharacter()

    elseif (characterNumber == 2) then
        ReplaceCharacter2()

    elseif (characterNumber == 3) then
        ReplaceCharacter3()

    elseif (characterNumber == 4) then
        ReplaceCharacter4()
    end
end

local function onCollision( self, event )
    -- for testing purposes
    --print( event.target )        --the first object in the collision
    --print( event.other )         --the second object in the collision
    --print( event.selfElement )   --the element (number) of the first object which was hit in the collision
    --print( event.otherElement )  --the element (number) of the second object which was hit in the collision
    --print( event.target.myName .. ": collision began with " .. event.other.myName )

    if ( event.phase == "began" ) then

        if  (event.target.myName == "no apple1") or 
            (event.target.myName == "no apple2") or
            (event.target.myName == "no apple3") or 
            (event.target.myName == "no apple4") or
            (event.target.myName == "no apple5") then

    ------------- NONE OF THIS SHOULD HAPPEN AS YOU NEVER LOSE LIVES -----------------------------

            -- add sound effect here

            -- remove runtime listeners that move the character
            RemoveArrowEventListeners()
            RemoveRuntimeListeners()

            -- remove the character from the display
            display.remove(character)

            -- decrease number of lives
            numLives = numLives - 1

            -- make sound for when the character gets hit
            hitSoundChannel = audio.play(hitSound)

            if (numLives == 1) then
                -- update hearts
                heart1.isVisible = true
                heart2.isVisible = false

                if (characterNumber == 1) then
                    timer.performWithDelay(200, ReplaceCharacter) 

                elseif (characterNumber == 2) then
                    timer.performWithDelay(200, ReplaceCharacter2)

                elseif (characterNumber == 3) then
                    timer.performWithDelay(200, ReplaceCharacter3)

                elseif (characterNumber == 4) then
                    timer.performWithDelay(200, ReplaceCharacter4)
                end

            elseif (numLives == 0) then
                -- update hearts
                heart1.isVisible = false
                heart2.isVisible = false
                timer.performWithDelay(200, YouLoseTransition)
            end
        end

        if  (event.target.myName == "apple1") or
            (event.target.myName == "apple2") or
            (event.target.myName == "apple3") or
            (event.target.myName == "apple4") or  
            (event.target.myName == "apple5") or
            (event.target.myName == "apple6") then
            -- adds questions answered and is where the win function is called when colliding with the door


            -- get the ball that the user hit
            theApple = event.target

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false

            -- show overlay with math question
            composer.showOverlay( "level1_question", { isModal = true, effect = "fade", time = 100})

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1
        end
        
        if (questionsAnswered == 5) then
            door.isVisible = true
        end

        if (event.target.myName == "door") then
            print(questionsAnswered)
            --check to see if the user has answered 5 questions
            if (questionsAnswered == 5) then
                -- after getting 3 questions right, go to the you win screen
                winSoundChannel = audio.play(winSound)
                character.isVisible = false
                trophy1 = 1
                composer.gotoScene( "level2_screen", {effect = "zoomOutInFadeRotate", time = 500})
            end
        end

        if (questionsAnswered == 3) then
            flyingBall.isVisible = true
        end

        if (questionsAnswered == 4) then
            flyingBall.isVisible = false
        end

           -- calls function which deletes the arrows
        if  (event.target.myName == "pointerArrow") then
            timer.performWithDelay(100, Die)
        end
            
        if  (event.target.myName == "pointerArrow2") then
            timer.performWithDelay(100, Die2)
        end  
            
        if  (event.target.myName == "pointerArrow3") then
            timer.performWithDelay(100, Die3)
        end

        if  (event.target.myName == "pointerArrow4") then
            timer.performWithDelay(100, Die4)
        end
            
        if  (event.target.myName == "pointerArrow5") then
            timer.performWithDelay(100, Die5)
        end

    end
end

-- adds collision listeners
local function AddCollisionListeners()
    -- if character collides with ball, onCollision will be called
    apple1.collision = onCollision
    apple1:addEventListener( "collision" )
    apple2.collision = onCollision
    apple2:addEventListener( "collision" )
    apple3.collision = onCollision
    apple3:addEventListener( "collision" )
    apple4.collision = onCollision
    apple4:addEventListener( "collision" )
    apple5.collision = onCollision
    apple5:addEventListener( "collision" )

    pointerArrow.collision = onCollision
    pointerArrow:addEventListener( "collision" )
    pointerArrow2.collision = onCollision
    pointerArrow2:addEventListener( "collision" )
    pointerArrow3.collision = onCollision
    pointerArrow3:addEventListener( "collision" )
    pointerArrow4.collision = onCollision
    pointerArrow4:addEventListener( "collision" )
    pointerArrow5.collision = onCollision
    pointerArrow5:addEventListener( "collision" )

    door.collision = onCollision
    door:addEventListener( "collision" )    

end

-- removes collision listeners
local function RemoveCollisionListeners()
    apple1:removeEventListener( "collision" )
    apple2:removeEventListener( "collision" )
    apple3:removeEventListener( "collision" )
    apple4:removeEventListener( "collision" )
    apple5:removeEventListener( "collision" )

    pointerArrow:removeEventListener( "collision" )
    pointerArrow2:removeEventListener( "collision" )
    pointerArrow3:removeEventListener( "collision" )
    pointerArrow4:removeEventListener( "collision" )
    pointerArrow5:removeEventListener( "collision" )

    door:removeEventListener( "collision" )
end     

-- adds physiscs to objects
local function AddPhysicsBodies()

    physics.addBody(leftW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(rightW, "static", {density=1, friction=0.3, bounce=0.2} ) 
    physics.addBody(topW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(floor, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(appleW, "static", {density=1, friction=0.3, bounce=0.2} )

    physics.addBody(apple1, "static", {density=0, friction=0, bounce=0} ) 
    physics.addBody(apple2, "static", {density=0, friction=0, bounce=0} ) 
    physics.addBody(apple3, "static", {density=0, friction=0, bounce=0} ) 
    physics.addBody(apple4, "static", {density=0, friction=0, bounce=0} ) 
    physics.addBody(apple5, "static", {density=0, friction=0, bounce=0} ) 

    physics.addBody(pointerArrow, "static", {density=0, friction=0, bounce=0} )
    physics.addBody(pointerArrow2, "static", {density=0, friction=0, bounce=0} ) 
    physics.addBody(pointerArrow3, "static", {density=0, friction=0, bounce=0} ) 
    physics.addBody(pointerArrow4, "static", {density=0, friction=0, bounce=0} ) 
    physics.addBody(pointerArrow5, "static", {density=0, friction=0, bounce=0} ) 

    physics.addBody(door, "static", {density=1, friction=0.3, bounce=0.2} )

end

-- removes physiscs from objects
local function RemovePhysicsBodies()

    physics.removeBody(leftW)
    physics.removeBody(rightW)
    physics.removeBody(topW)
    physics.removeBody(floor)
    physics.removeBody(appleW)

    physics.removeBody(door)
 
end

-- starts the timer
local function StartTimer()
    -- create countdown timer that loops infinetely
    secondsLeft = totalSeconds
    countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end

-- stops the timer
local function StopTmers()
    timer.cancel(countDownTimer)
end

-- basicaly resets the game so if you were to reload it it wouldnt break/dissapear
local function StopEveryThing()
    countDownTimer = timer.stop
    secondsLeft = totalSeconds
    character.isVisible = true
    numLives = 3
    apple1.isVisible = true
    apple2.isVisible = true
    apple3.isVisible = true
    apple4.isVisible = true
    apple5.isVisible = true
    heart1.isVisible = true
    heart2.isVisible = true
    heart3.isVisible = true
    pointerArrow.isVisible = true
    pointerArrow2.isVisible = true
    pointerArrow3.isVisible = true
    pointerArrow4.isVisible = true
    pointerArrow5.isVisible = true



end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- deletes the apple you touched if you are wrong
function ResumeGame()
        -- make character visible again
    character.isVisible = true
    -- add sound if you qare incorrect
    hitSoundChannel = audio.play(hitSound)
        -- make character visible again
    character.isVisible = true
    numLives = numLives - 1  
    if (questionsAnswered > -1) then
        if (theApple ~= nil) and (theApple.isBodyActive == true) then
            physics.removeBody(theApple)
            theApple.isVisible = false
        end
    end

end
-- deletes the apple you touched if you are right
function ResumeGame2()
   --  make character visible again
    character.isVisible = true
    -- play sound when correct
    winSoundChannel = audio.play(winSound)
        -- make character visible again
    character.isVisible = true  
    if (questionsAnswered > -1) then
        if (theApple ~= nil) and (theApple.isBodyActive == true) then
            physics.removeBody(theApple)
            theApple.isVisible = false
        end
    end

end

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level1ScreenNathanC@2x.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

        -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    

    flyingBall = display.newImageRect("Images/ApplesNathan@2x.png", 10, 10)
    flyingBall.x = 500
    flyingBall.y = display.contentHeight/2
    flyingBall.isVisible = false

    hiddenText = display.newText("Congrats You found the hiddenEasterEgg", 0, 0)
    hiddenText.isVisible = false
    hiddenText.x = display.contentWidth/2
    hiddenText.y = 580
    hiddenText:scale(2, 2)
    hiddenText:setTextColor(0, 1, 0)

    -- create apples
    apple1 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple1.x = 425
    apple1.y = 723
    apple1:scale(.3,.3)
    apple1.myName = "apple1"

    apple2 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple2.x = 537
    apple2.y = 727
    apple2:scale(.3,.3)
    apple2.myName = "apple2"

    apple3 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple3.x = 640
    apple3.y = 723
    apple3:scale(.3,.3)
    apple3.myName = "apple3"

    apple4 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple4.x = 750
    apple4.y = 727
    apple4:scale(.3,.3)
    apple4.myName = "apple4"

    apple5 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple5.x = 870
    apple5.y = 723
    apple5:scale(.3,.3)
    apple5.myName = "apple5"

    sceneGroup:insert(apple1)
    sceneGroup:insert(apple2)
    sceneGroup:insert(apple3)
    sceneGroup:insert(apple4)
    sceneGroup:insert(apple5)

        -- Insert the Hearts
    heart1 = display.newImageRect("Images/heart.png", 80, 80)
    heart1.x = 270
    heart1.y = 90
    heart1.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart1 )

    heart2 = display.newImageRect("Images/heart.png", 80, 80)
    heart2.x = 360
    heart2.y = 90
    heart2.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart2 )

    heart3 = display.newImageRect("Images/heart.png", 80, 80)
    heart3.x = 450
    heart3.y = 90
    heart3.isVisible = true
    sceneGroup:insert( heart3 )


        -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*8.5/9,
        y = display.contentHeight*1/7,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressedYourName@2x.png",
        overFile = "Images/BackButtonPressedYourName@2x.png",

        width = 130,
        height = 65,

        -- Setting Functional Properties
        onRelease = BackTransition

    } )

    backButton.isVisible = true -- change to work or not if thaat is what you wish

    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( backButton )

    clockText = display.newText( "Seconds left = " .. secondsLeft .. "", display.contentHeight*8/9, display.contentWidth*1/10, nil, 50 )


    --Insert the right arrow
    rArrow = display.newImageRect("Images/RightArrowUnpressed.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.y = display.contentHeight * 9 / 10

    -- insert image for up arrow
    uArrow = display.newImageRect("Images/UpArrowUnpressed.png", 50, 100)
    uArrow.x = display.contentWidth * 8.2 / 10
    uArrow.y = display.contentHeight * 8 / 10
    uArrow.isVisible = false

    -- insert image for left arrow
    lArrow = display.newImageRect("Images/LeftArrowUnpressed.png", 100, 50)
    lArrow.x = display.contentWidth * 7.2 / 10
    lArrow.y = display.contentHeight * 9 / 10

    -- display door
    door = display.newImage("Images/coolDogHouse.png", 50, 50)
    door.x = display.contentWidth*7.6/8 
    door.y = display.contentHeight*6.4/7
    door.myName = "door"
    door:scale(0.8,0.8)
    
    -- create mute button
    muteButton = display.newImageRect("Images/Mute.png", 200, 200)
    muteButton.x = display.contentWidth*1.5/10
    muteButton.y = display.contentHeight*1.3/10
    muteButton.isVisible = true

    -- create unmute button
    unmuteButton = display.newImageRect("Images/UnMute.png", 200, 200)
    unmuteButton.x = display.contentWidth*1.5/10
    unmuteButton.y = display.contentHeight*1.3/10
    unmuteButton.isVisible = false

    --WALLS--

    leftW = display.newLine( 0, 0, 0, display.contentHeight)
    leftW.isVisible = true

    rightW = display.newLine( 1024, 0, 1024, display.contentHeight)
    rightW.isVisible = true

    topW = display.newLine( 0, 0, display.contentWidth, 0)
    topW.isVisible = false

    -- this wall exists as a saftey so the game doesnt crash.
    appleW = display.newLine(0, 550, display.contentWidth, 550)
    appleW.isVisible = false

    -- create floor   
    floor = display.newImageRect("Images/Ground.png", 1000, 100)
    floor.x = display.contentCenterX
    floor.y = display.contentHeight * 2.1/2

    -- create the five pointer arrows that direct you towards the next apple
    pointerArrow = display.newImageRect("Images/Arrow.png", 50, 25)
    pointerArrow.x = display.contentWidth * 3.7 / 10
    pointerArrow.y = display.contentHeight * 9.41 / 10
    pointerArrow.myName = "pointerArrow"

    pointerArrow2 = display.newImageRect("Images/Arrow.png", 50, 25)
    pointerArrow2.x = display.contentWidth * 4.7 / 10
    pointerArrow2.y = display.contentHeight * 9.41 / 10
    pointerArrow2.myName = "pointerArrow2"

    pointerArrow3 = display.newImageRect("Images/Arrow.png", 50, 25)
    pointerArrow3.x = display.contentWidth * 5.8 / 10
    pointerArrow3.y = display.contentHeight * 9.41 / 10
    pointerArrow3.myName = "pointerArrow3"

    pointerArrow4 = display.newImageRect("Images/Arrow.png", 50, 25)
    pointerArrow4.x = display.contentWidth * 6.8 / 10
    pointerArrow4.y = display.contentHeight * 9.41 / 10
    pointerArrow4.myName = "pointerArrow4"   

    pointerArrow5 = display.newImageRect("Images/Arrow.png", 50, 25)
    pointerArrow5.x = display.contentWidth * 7.9 / 10
    pointerArrow5.y = display.contentHeight * 9.41 / 10
    pointerArrow5.myName = "pointerArrow5"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( floor )
    sceneGroup:insert( topW )
    sceneGroup:insert( rightW )
    sceneGroup:insert( leftW )
    sceneGroup:insert( door )
    sceneGroup:insert( lArrow )
    sceneGroup:insert( rArrow )
    sceneGroup:insert( uArrow ) 
    sceneGroup:insert( appleW )
    sceneGroup:insert(unmuteButton)
    sceneGroup:insert(muteButton)
    sceneGroup:insert(clockText)
    sceneGroup:insert(pointerArrow)
    sceneGroup:insert(pointerArrow2)
    sceneGroup:insert(pointerArrow3)
    sceneGroup:insert(pointerArrow4)
    sceneGroup:insert(pointerArrow5)
    sceneGroup:insert( hiddenText )
    sceneGroup:insert(flyingBall)

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
        -- Example: start timers, begin animation, play audio, etc.
        -- stop sound
        bkgMusicLevel1Channel = audio.play(bkgMusicLevel1, { channel=6, loops=-1 } )
        muteButton:addEventListener("touch", Mute)
        unmuteButton:addEventListener("touch", UnMute)    
        questionsAnswered = 0
        flyingBall:addEventListener("touch", FlyingBallTouch)   

        -- make all soccer balls visible
        MakeAppleVisible()

        -- add collision listeners to objects
        AddCollisionListeners()
        -- create the character, add physics bodies and runtime listeners
        CharacterSelect() 

        -- add the physiscs
        AddPhysicsBodies()

        -- call the starting timer
        StartTimer()

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
        bkgMusicLevel1Channel = audio.stop()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

        -- remove all the stuff you added earlier
        RemoveCollisionListeners()
        RemovePhysicsBodies()

        physics.stop()
        RemoveArrowEventListeners()
        RemoveRuntimeListeners()
        display.remove(character)
        stopDieTimer()
        StopTmers()
        StopEveryThing()
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