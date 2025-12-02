extends Node

@onready var MenuMusic = $MenuMusic
@onready var Phase1Music = $Phase1Music
@onready var Phase2Music = $Phase2Music
var volume : float = 0.0

func update_music_volume():
	var db_volume = linear_to_db(volume)
	
	MenuMusic.volume_db = db_volume
	Phase1Music.volume_db = db_volume
	Phase2Music.volume_db = db_volume

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
