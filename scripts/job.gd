class_name Job extends Node2D

# This class should probably have some timer or it may be better to let the 
# job scheduler handle it

# make the job start
func start():
	print("Job started!")
	
func getJobCountdown() -> float:
	return 0.0

signal job_completed(job: Job)
signal job_failed(job: Job)

# when player finishes job successfully
func finish():
	print("Job completed successfully!")
	job_completed.emit(self)

# if task is not done in time
func fail():
	job_failed.emit(self)
	
func getJobDescription():
	return "This is a placeholder job description!"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _to_string() -> String:
	return "BaseJob(%s)" % getJobDescription()
