extends VBoxContainer

export(Texture) var bone_pic
export(Texture) var silber_pic
export(Texture) var cucaracha_pic

onready var names = [$Racer/Label,$Racer2/Label,$Racer3/Label,$Racer4/Label]
onready var pics = [$Racer/TextureRect,$Racer2/TextureRect,$Racer3/TextureRect,$Racer4/TextureRect]

class DistanceSorter:
	static func sort_ascending(a, b):
		if a[1] > b[1]:
			return true
		return false

func update_order(racers):
	racers.sort_custom(DistanceSorter, "sort_ascending")
	for i in range(0,4):
		names[i].text = racers[i][0]
		match racers[i][2]:
			"Bone":
				pics[i].texture = bone_pic
			"Silber":
				pics[i].texture = silber_pic
			"Cucaracha":
				pics[i].texture = cucaracha_pic

func get_final_order(racers):
	racers.sort_custom(DistanceSorter, "sort_ascending")
	return racers
