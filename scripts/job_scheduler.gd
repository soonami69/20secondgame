extends Node2D

var timer: float = 20.0
var timeSinceLastJob: float = 0.0
var delay: float = 5.0
var isRunning: bool = false
@export var jobs: Array[Job] = []

var runningJobs: Array = []

func endGame():
	print("Game over!") # placeholder game over function
	isRunning = false

func start():
	isRunning = true
	
# function for scheduling and running the jobs for the player to do
func handleJobQueue():
	# we duplicate so we don't mutate the array we are iterating over
	for task in runningJobs.duplicate():
		if timer < task.deadline:
			task.job.fail()
			runningJobs.erase(task)
	if jobs.size() > 0 and timeSinceLastJob >= delay:
		var job: Job = jobs.pop_front()
		job.start()
		var endTime = timer - job.getJobCountdown()
		timeSinceLastJob = 0.0
		
		runningJobs.append({
			"job": job,
			"deadline": endTime
		})
		
		print("Job added with start at: ", timer, " and end at: ", endTime)

func _on_job_finished(job: Job):
	print("JobScheduler: Job finished!", job)
	
	for task in runningJobs:
		if task.job == job:
			runningJobs.erase(task)
			break
	
func _on_job_failed(job: Job):
	# end the game
	print("JobScheduler: Job failed!", job)
	endGame()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isRunning = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isRunning:
		timer -= delta
		timeSinceLastJob += delta
		handleJobQueue()
		if timer < 0:
			endGame()
