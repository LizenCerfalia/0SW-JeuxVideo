extends Node

@onready var MenuMusic = $MenuMusic
@onready var Phase1Music = $Phase1Music
@onready var Phase2Music = $Phase2Music
var volume = 0

func PlayMenuMusic():
	Phase1Music.stop()
	Phase2Music.stop()
	MenuMusic.play()
	
func PlayPhase1Music():
	MenuMusic.stop()
	Phase1Music.play()
	
func PlayPhase2Music():
	MenuMusic.stop()
	Phase1Music.stop()
	Phase2Music.play()
