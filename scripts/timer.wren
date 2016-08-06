// Timer.wren
// autor: Andrei Rudenko (25.07.2016)


class Timer {
	static timers { __timers }

	static init() {
		System.print("Timer init")
		__timers = []
	}

	static update(elapsed) {
		for (timer in __timers){
			if (timer.active && !timer.finished && timer.timeLimit >= 0){
				timer.update_(elapsed)
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

		_elapsedTime = 0
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

	elapsedTime { _elapsedTime }
	timeLimit { _timeLimit }

	timeLeft { _timeLimit - _elapsedTime }
	loopsLeft { _loops - _loopsCounter }
	elapsedLoops { _loopsCounter }
	progress { (_timeLimit > 0) ? (_elapsedTime / _timeLimit) : 0 }

	active=(value) { _active = value } 

	elapsedTime=(value) { _elapsedTime = value } 
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

		_elapsedTime = 0
		_timeLimit = timeLimit_.abs
		
		_loops = 1
		_loopsCounter = 0
		return this
	}

	start(elapsedTime_, timeLimit_) {
		if (!_inArray) {
			__timers.add(this)
			_inArray = true
		}
		
		_active = true
		_finished = false

		_elapsedTime = elapsedTime_.abs
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
		if (_onComplete != null) _onComplete.call()

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

	update_(elapsed) {

		if (_onUpdate != null) _onUpdate.call()

		_elapsedTime = _elapsedTime + elapsed
		while ((_elapsedTime >= _timeLimit) && _active && !_finished) {
			_elapsedTime = _elapsedTime - _timeLimit
			_loopsCounter = _loopsCounter + 1
			
			if (_loops > 0 && (_loopsCounter >= _loops)) {
				stop()
			} else {
				if (_onRepeat != null) _onRepeat.call()
			}
		}
	}

	elapsed(t) {
		return _elapsedTime >= t
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

}
