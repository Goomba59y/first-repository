extends Navigation2D


func _ready():
	Nodes.set_meta("Navi", self)

func Navi(object, from, to) :
	object.path = get_simple_path(from, to)
