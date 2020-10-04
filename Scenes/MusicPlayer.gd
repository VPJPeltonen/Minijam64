class_name MusicPlayer
extends Node

var song_map : Dictionary = {}
var currentSong : AudioStreamPlayer = null

func _ready():
	# Add AudioStreamPlayers as children to this node
	for songPlayer in get_children():
		song_map[songPlayer.name] = songPlayer
		
func play(song : String):
	# Pause current song
	if currentSong != null:
		currentSong.stop()
		
	# Load new song
	if (song_map.has(song)):
		song_map[song].play(0)
		
func pause(): if currentSong != null: currentSong.pause()

func unpause(): if currentSong != null: currentSong.play()

func stop(): if currentSong != null: currentSong.stop()
