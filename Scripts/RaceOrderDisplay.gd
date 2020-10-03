extends VBoxContainer

onready var names = [$Racer/Label,$Racer2/Label,$Racer3/Label,$Racer4/Label]

class DistanceSorter:
	static func sort_ascending(a, b):
		if a[1] > b[1]:
			return true
		return false

func update_order(order):
	order.sort_custom(DistanceSorter, "sort_ascending")
	for i in range(0,4):
		names[i].text = order[i][0]
