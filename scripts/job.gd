class_name Job extends Node

# This class should probably have some timer or it may be better to let the 
# job scheduler handle it

# make the job start
func start():
	print("Job started!")

# when player finishes job successfully
func finish():
	print("Job completed successfully!")

# if task is not done in time
func fail():
	print("Job failed! Game over!")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
