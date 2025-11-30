extends Job

var timeToComplete: float = 4.0
var dragging: bool = false
var start_area_y := 0.0
var dragDistance := 40.0
var mouseOffset: float = 0.0
var timeToReturn = 3.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.hide()
	
func start():
	super.start()
	$Area2D.show()
	
func finish():
	dragging = false
	super.finish()
	
func getJobCountdown() -> float:
	return timeToComplete

func releaseDrag():
	if dragging:
		dragging = false
		print("Drag released")

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				print("Dragging started!")
				dragging = true
				start_area_y = $Area2D.position.y
				mouseOffset = self.make_input_local(event).position.y - start_area_y
			else:
				releaseDrag()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			releaseDrag()
	if dragging and event is InputEventMouseMotion:
		# event.relative is the change in mouse position since last frame
		var localEvent = self.make_input_local(event)
		var drag_amount = localEvent.position.y - mouseOffset
		$Area2D.position.y = clamp(drag_amount, start_area_y, start_area_y + dragDistance)

		if $Area2D.position.y >= start_area_y + dragDistance:
			finish()
			$Area2D.hide()

func _process(delta: float) -> void:
	if not dragging:
		if $Area2D.position.y > start_area_y:
			$Area2D.position.y -= dragDistance * (delta / timeToReturn)

func _to_string() -> String:
	return "Lever(%s)" % getJobDescription()
