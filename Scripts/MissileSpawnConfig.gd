extends Node

class_name MissileSpawnConfig

var _count: int
var _duration: int
var _currentCount: int = 0

func init(count, duration):
	_count = count
	_duration = duration
	_currentCount = 0
	
func timePerBurst():
	return _duration / float(_count)

func start():
	_currentCount = 0
