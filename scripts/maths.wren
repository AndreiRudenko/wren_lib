class Maths {

	static EPSILON { 1e-10 }

	static clamp(value, a, b) {
		return (value < a) ? a : (( value > b) ? b : value)
	}

	static clampBottom(value, a, b) { 
		return value < a ? a : value
	}

	static lerp(start, end, t) {
		return start + t * (end - start)
	}

	static inverseLerp(start, end, value) {
		return end == start ? 0.0 : (value - start) / (end - start)
	}

	static map(istart, iend, ostart, oend, value) {
		return ostart + (oend - ostart) * ((value - istart) / (iend - istart))
	}

	static weightedAvg(value, target, slowness) {
		if(slowness == 0 ) { slowness = Maths.EPSILON }
		return ((value * (slowness - 1)) + target) / slowness
	}

	static withinRange(value, start_range, end_range) { 
		return value >= start_range && value <= end_range
	}

	static wrapAngle(degrees, lower, upper) { 
		var radians = radians(degrees)
		var distance = upper - lower
		var times = ((degrees - lower) / distance).floor

		return degrees - (times * distance)
	}

	static smoothStep( x, min, max ) {
		if (x <= min) return 0
		if (x >= max) return 1
		
		x = ( x - min ) / ( max - min )

		return x * x * ( 3 - 2 * x )
	}

	static smootherStep( x, min, max ) {
		if (x <= min) return 0
		if (x >= max) return 1

		x = ( x - min ) / ( max - min )

		return x * x * x * ( x * ( x * 6 - 15 ) + 10 )
	}
	
	static sign( x ) {
		return (x >= 0) ? 1 : -1
	}

	static sign0( x ) {
		return (x < 0) ? -1 : ((x > 0) ? 1 : 0)
	}

	static distanceSq(dx, dy) {
		return dx * dx + dy * dy
	}

	static distance(dx, dy) {
		return distanceSq(dx,dy).sqrt
	}

	static radians( degrees ) {
		return degrees * 0.017453292519943 // degrees * (Num.pi / 180)
	}

	static degrees( radians ) {
		return radians * 57.295779513082 // degrees * (180 / Num.pi)
	}

	static round(n) {
		return (n + 0.5).floor
	}

	static nearestPowerOfTwo(value) { 
		value = value - 1
		value = value | (value >> 1)
		value = value | (value >> 2)
		value = value | (value >> 4)
		value = value | (value >> 8)
		value = value | (value >> 16)
		value = value + 1

		return value
	}

	static nextPowerOfTwo(value) {
		value = value | (value >> 1)
		value = value | (value >> 2)
		value = value | (value >> 4)
		value = value | (value >> 8)
		value = value | (value >> 16)
		value = value + 1

		return value
	}

}
