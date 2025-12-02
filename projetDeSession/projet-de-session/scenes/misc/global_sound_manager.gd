extends Node

@onready var SnapSFX = $Snap
@onready var HealSFX = $Heal
@onready var BigFireballSFX = $BigFireball
@onready var BigFireballImpactSFX = $BigFireballImpact
@onready var LightFireballSFX = $LightFireball
@onready var UltimatumSFX = $Ultimatum
@onready var AirSlashSFX = $AirSlash
@onready var SpinningSlashSFX = $SpinningSlash
@onready var MetalImpactSFX = $MetalImpact
@onready var StanceSFX = $Stance
@onready var TeleportSFX = $Teleport
@onready var RessurectSFX = $Ressurect
@onready var DashSFX = $Dash
var volume: float = 0.8

func update_sfx_volume():
	var db_volume = linear_to_db(volume)
	
	SnapSFX.volume_db = db_volume
	HealSFX.volume_db = db_volume
	BigFireballSFX.volume_db = db_volume
	BigFireballImpactSFX.volume_db = db_volume
	LightFireballSFX.volume_db = db_volume
	UltimatumSFX.volume_db = db_volume
	AirSlashSFX.volume_db = db_volume
	SpinningSlashSFX.volume_db = db_volume
	MetalImpactSFX.volume_db = db_volume
	StanceSFX.volume_db = db_volume
	TeleportSFX.volume_db = db_volume
	RessurectSFX.volume_db = db_volume
	DashSFX.volume_db = db_volume

func play_snap_sfx():
	SnapSFX.play()

func play_heal_sfx():
	HealSFX.play()

func play_big_fireball_sfx():
	BigFireballSFX.play()

func play_big_fireball_impact_sfx():
	BigFireballImpactSFX.play()
	
func play_light_fireball_sfx():
	LightFireballSFX.play()

func play_ultimatum_sfx():
	UltimatumSFX.play()

func play_air_slash_sfx():
	AirSlashSFX.play()

func play_spinning_slash_sfx():
	SpinningSlashSFX.play()

func play_metal_impact_sfx():
	MetalImpactSFX.play()

func play_stance_sfx():
	StanceSFX.play()

func play_teleport_sfx():
	TeleportSFX.play()

func play_ressurect_sfx():
	RessurectSFX.play()

func play_dash_sfx():
	DashSFX.play()
