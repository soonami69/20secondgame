extends Node2D

var timer: float = 20.0
var isRunning: bool = false
@export var jobs: Array[Job] = []

func endGame():
	print("Game over!") # placeholder game over function

func _init(jobArray: Array[Job], initialTimer: float = 20.0):
	timer = initialTimer
	jobs = jobArray
	
func start():
	isRunning = true
	
# function for scheduling and running the jobs for the player to do
func handleJobQueue():
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isRunning:
		timer -= delta
		handleJobQueue()
	if timer < 0:
		endGame()
