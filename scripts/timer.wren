// Timer.wren
// autor: Andrei Rudenko (25.07.2016)


class Timer {

	static timers { __timers }

	static init() {
		__timers = []
	}

	static update() {
		var time_ = System.clock
		for (timer in __timers){
			if (timer.active && !timer.finished && timer.timeLimit >= 0){
				timer.update_(time_)
			}
		}
	}

	static destroy() {
		for (timer in __timers){
			timer.destroy()
		}
		__timers = null
	}

	static empty() {
		for (timer in __timers){
			timer.destroy()
		}
		__timers.clear()
	}

	static schedule(timeLimit_) {
		var t = Timer.new()
		t.start(timeLimit_)
		return t
	}

	static schedule(elapsedTime_, timeLimit_) {
		var t = Timer.new()
		t.start(elapsedTime_, timeLimit_)
		return t
	}

	construct new() {
		_startTime = 0
		_timeOffset = 0
		_timeLimit = 0
		_loops = 0
		_active = false
		_finished = false

		_loopsCounter = 0
		_inArray = false

		_onComplete = null
		_onRepeat = null
		_onUpdate = null
	}

	finished { _finished }
	active { _active }

	timeLimit { _timeLimit }

	elapsedTime { System.clock - _startTime }
	timeLeft { (_startTime + _timeLimit) - (System.clock + _timeOffset) }
	elapsedLoops { _loopsCounter }
	loopsLeft { _loops - _loopsCounter }

	progress { (_timeLimit > 0) ? ((elapsedTime + _timeOffset) / _timeLimit) : 0 }

	active=(value) { _active = value } 

	timeLimit=(value) { _timeLimit = value } 

	pause() { _active = false }
	resume() { _active = true }

	start(timeLimit_) {
		if (!_inArray) {
			__timers.add(this)
			_inArray = true
		}
		
		_active = true
		_finished = false

		_timeOffset = 0
		_startTime = System.clock
		_timeLimit = timeLimit_.abs
		
		_loops = 1
		_loopsCounter = 0

		return this
	}

	start(currentTime_, timeLimit_) {
		if (!_inArray) {
			__timers.add(this)
			_inArray = true
		}
		
		_active = true
		_finished = false

		_timeOffset = currentTime_
		_startTime = System.clock
		_timeLimit = timeLimit_.abs
		
		_loops = 1
		_loopsCounter = 0

		return this
	}


	reset() {
		start(_timeLimit)
		return this
	}
	
	reset(newTime_) {
		start(newTime_)
		return this
	}

	onComplete(value) {
		if (value is Fn) {
			_onComplete = value 
		}
		return this
	}

	onRepeat(value) {
		if (value is Fn) {
			_onRepeat = value 
		}
		return this
	}

	onUpdate(value) {
		if (value is Fn) {
			_onUpdate = value 
		}
		return this
	}

	repeat() {
		_loops = 0
		return this
	}

	repeat(times) {
		_loops = times
		return this
	}

	stop() {
		if (_onComplete != null) {
			_onComplete.call()
		}

		_finished = true
		_active = false
		
		if (_inArray){
			for (i in 0...__timers.count-1) {
				if (__timers[i] == this) {
					__timers.removeAt(i)
				}
			}
			_inArray = false
		}
	}

	elapsed(t) { 
		return _startTime + _t < System.clock 
	}

	destroy() {
		_finished = true
		_active = false
		
		if (_inArray){
			for (i in 0...__timers.count-1) {
				if (__timers[i] == this) {
					__timers.removeAt(i)
				}
			}
			_inArray = false
		}
		
		_onComplete = null
		_onRepeat = null
		_onUpdate = null
	}

	update_(time_) {
		if (_onUpdate != null) {
			_onUpdate.call()
		}

		while ( _active && !_finished && ( _startTime + _timeLimit < time_ + _timeOffset ) ) {
			_loopsCounter = _loopsCounter + 1
			
			if (_loops > 0 && (_loopsCounter >= _loops)) {
				stop()
				break
			}

			_timeOffset = 0

			_startTime = _startTime + _timeLimit

			if (_onRepeat != null) {
				_onRepeat.call()
			}
		}
	}

}
