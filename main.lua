-- Title: SampleVideoGame
-- Name: Liam Csiffary
-- Course: ICS2O/3C
-- This program is my first game where you pick up a turtle and drop it into a box.
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------
characterNumber = 1
characterColor = 1
hiddenEasterEgg = 0
hiddenEasterEgg2 = 0
trophy1 = 0
trophy2 = 0
trophy3 = 0
trophy4 = 0
-- Go to the intro screen

composer.gotoScene( "splash_screen" )

