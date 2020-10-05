class_name SoundPlayer3D
extends Spatial

var sound_map : Dictionary = {}

func _ready():
	# Add AudioStreamPlayers as children to this node
	for soundPlayer in get_children():
		sound_map[soundPlayer.name] = soundPlayer
		
func play(sound : String):
	# Load new sound
	if (sound_map.has(sound)):
		sound_map[sound].play(0)
	
func stopAll():
	for sound in sound_map.values(): sound.stop()
