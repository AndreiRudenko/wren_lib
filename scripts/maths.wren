// ported from https://github.com/underscorediscovery/luxe/blob/master/luxe/utils/Maths.hx


class Maths {

	static lerp( value, target, t ) {
    	t = Maths.clamp(t, 0, 1)
    	return (value + t * (target - value))
    }

    static weighted_avg( value, target, slowness ) {
            //:todo: use an epsilon
        if( slowness == 0 ) { slowness = 0.00000001 }
        return ((value * (slowness - 1)) + target) / slowness
    }


	static clamp(value, a, b) { 
        return ( value < a ) ? a : ( ( value > b ) ? b : value )
	}

	static clamp_bottom(value, a, b) { 
        return value < a ? a : value
	}

	static within_range(value, start_range, end_range) { 
        return value >= start_range && value <= end_range
	}

	static wrap_angle(degrees, lower, upper) { 
		var radians = radians(degrees)
		var distance = upper - lower
		var times = ((degrees - lower) / distance).floor

		return degrees - (times * distance)
	}

	static nearest_power_of_two(value) { 

		value = value - 1
		value = value | (value >> 1)
		value = value | (value >> 2)
		value = value | (value >> 4)
		value = value | (value >> 8)
		value = value | (value >> 16)
		value = value + 1

		return value
	}

	static map_linear( value, a1, a2, b1, b2 ) { 
        return b1 + ( value - a1 ) * ( b2 - b1 ) / ( a2 - a1 )
	}

    static smoothstep( x, min, max ) {

        if (x <= min) {
            return 0
        }

        if (x >= max) {
            return 1
        }

        x = ( x - min ) / ( max - min )

        return x * x * ( 3 - 2 * x )

    }

    static smootherstep( x, min, max ) {

        if (x <= min) {
            return 0
        }

        if (x >= max) {
            return 1
        }

        x = ( x - min ) / ( max - min )

        return x * x * x * ( x * ( x * 6 - 15 ) + 10 )

    }
    
	static sign( x ) {
		return (x >= 0) ? 1 : -1
	}

	static sign0( x ) {
        return (x < 0) ? -1 : ((x > 0) ? 1 : 0)
	}
	
    static radians( degrees ) {
        return degrees * 0.017453292519943 // degrees * _PI_OVER_180
    }

    static degrees( radians ) {
        return radians * 57.295779513082 // degrees * _180_OVER_PI
    }

    static round(n) {
        return (n + 0.5).floor
    }

	// _PI_OVER_180 = 3.14159265358979 / 180 // 0.017453292519943
	// _180_OVER_PI = 180 / 3.14159265358979 // 57.295779513082
}
