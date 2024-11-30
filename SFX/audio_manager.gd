extends Node2D

@export var max_active_sounds = 50
var active_sounds = []

func play_sound(sound: AudioStreamPlayer2D): 
	if sound == null: return
	if active_sounds.size() < max_active_sounds: 
		if !sound.is_connected("finished",_on_sound_finished): sound.connect("finished", _on_sound_finished) 
		sound.play() 
		active_sounds.append(sound) 

func _on_sound_finished(): 
	active_sounds.pop_back()
	active_sounds.pop_back()
