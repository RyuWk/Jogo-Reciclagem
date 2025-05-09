extends Sprite2D

func _ready():
	# Recebe as coordenadas do sprite a ser mostrado, caracterizado pelo tipo e variação
	SignalBus.novo_lixo.connect(_on_data_received)

func _on_data_received(lixos): # Altera o sprite do lixo, baseado nos dados
	var rect = region_rect
	rect.position.x = lixos[1] * 16 # Shift na variação de sprite
	rect.position.y = lixos[0] * 16 # Shift no sprite do tipo de lixo
	region_rect = rect
