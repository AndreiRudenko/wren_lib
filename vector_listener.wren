// ported from https://github.com/underscorediscovery/luxe/blob/master/phoenix/Vector.hx

import "assets/maths" for Maths

class Vector {

	construct new() {
		_x = 0
		_y = 0

		_ignore_get_listeners = false
		_ignore_set_listeners = false
	}

	construct new(x,y) {
		_x = x
		_y = y

		_ignore_get_listeners = false
		_ignore_set_listeners = false
	}

	x=(value) { 
		_x = value 
        if(_listen_set_x != null && !_ignore_set_listeners) _listen_set_x.call(_x)
	} 

	y=(value) { 
		_y = value 
        if(_listen_set_y != null && !_ignore_set_listeners) _listen_set_y.call(_y)
	}

	[i]=(value) {
		if (i == 0) {
			x = value
		} else if (i == 1) {
			y = value
		}
		return this
	}

	listen_get_x=(value) { 
		if (value is Fn) {
			_listen_get_x = value 
		}
	} 

	listen_get_y=(value) { 
		if (value is Fn) {
			_listen_get_y = value 
		}
	} 

	listen_set_x=(value) { 
		if (value is Fn) {
			_listen_set_x = value 
		}
	} 

	listen_set_y=(value) { 
		if (value is Fn) {
			_listen_set_y = value 
		}
	} 

	ignore_get_listeners=(value) {_ignore_get_listeners = value}
	ignore_set_listeners=(value) {_ignore_set_listeners = value}

	length=(value) {
		normalize().multiplyScalar(value)
	}
	
	angle2D=(value) {
		var len = length
		y = value.cos * len
		x = value.sin * len
		return value
	}

	x { 
        if(_listen_get_x != null && !_ignore_get_listeners){
        	_x = _listen_get_x.call()
        	return _x
        } else {
        	return _x
        }
	} 

	y { 
        if(_listen_get_y != null && !_ignore_get_listeners){
        	_y = _listen_get_y.call()
        	return _y
        } else {
        	return _y
        }
	}

	[i] {
		if (i == 0) {
			return x
		} else if (i == 1) {
			return y
		} else {
			return null
		}
	}

	ignore_get_listeners { _ignore_get_listeners }
	ignore_set_listeners { _ignore_set_listeners }

	length { 
		var x_ = x
		var y_ = y
		return ( x_ * x_ + y_ * y_ ).sqrt
	}

	lengthsq { 
		var x_ = x
		var y_ = y
		return x_ * x_ + y_ * y_
	}

	angle2D { 
		return y.atan(x)
	}

	inverted { 
		return Vector.new(-x, -y) 
	}

	normalized { 
		return Vector.Divide( this, length )
	}

	copy_from(other) { 
		x = other.x
		y = other.y 
		return this
	}

	set(x, y) { 

        var prev = _ignore_set_listeners

        _ignore_set_listeners = true

		_x = x
		_y = y 

        _ignore_set_listeners = prev

        if(_listen_set_x != null && !_ignore_set_listeners) _listen_set_x.call(_x)
        if(_listen_set_y != null && !_ignore_set_listeners) _listen_set_y.call(_y)

	}


	lerp( other, t ) {
		x = Maths.lerp(x, other.x, t)
		y = Maths.lerp(y, other.y, t)
		return this
	}

	int() {
		x = Maths.round(x)
		y = Maths.round(y)
		return this
	}

	int_x() {
		x = Maths.round(x)
		return this
	}

	int_y() {
		y = Maths.round(y)
		return this
	}


	equals(value) { 
		return x == value.x && y == value.y
	}

	clone() { 
		return Vector.new(x, y)
	}

	normalize() {
		return divideScalar( length )
	}

	dot(other) { 
		return x * other.x + y * other.y
	}

	// cross(other) {
	// 	return x * other.x + y * other.y
	// }

	invert() {
		x = -x
		y = -y
		return this
	}

	add(other) { 
		if (other is Num) {
			x = x + other
			y = y + other
		} else {
			set(x + other.x, y + other.y )
		}
		return this
	}

	add(x, y) { 
		this.x = this.x + x
		this.y = this.y + y 
		return this
	}

	subtract(other) { 
		if (other is Num) {
			x = x - other
			y = y - other
		} else {
			set(x - other.x, y - other.y )
		}
		return this
	}

	subtract(x, y) { 
		this.x = this.x - x
		this.y = this.y - y 
		return this
	}

	multiply(other) { 
		if (other is Num) {
			x = x * other
			y = y * other
		} else {
			set(x * other.x, y * other.y )
		}
		return this
	}

	multiply(x, y) { 
		this.x = this.x * x
		this.y = this.y * y 
		return this
	}

	divide(other) { 
		if (other is Num) {
			x = x / other
			y = y / other
		} else {
			set(x / other.x, y / other.y )
		}
		return this
	}

	divide(x, y) { 
		this.x = this.x / x
		this.y = this.y / y 
		return this
	}

	truncate(max) { 
        length = (max..length).min
		return this
	}

	rotationTo(other) { 
        var theta = (other.x - x).atan(other.y - y)
        var r = -(180.0 + (theta * 180.0/Num.pi))
        return r
	}

	degrees() { 
		x = Maths.degrees(x)
		y = Maths.degrees(y)
		return this
	}

	radians() { 
		x = Maths.radians(x)
		y = Maths.radians(y)
		return this
	}

	toString { "{ x:%(x), y:%(y) }" }


	static Add(a, b) { 
		if (b is Num) {
			return Vector.new(a.x + b, a.y + b)
		} else {
			return Vector.new(a.x + b.x, a.y + b.y)
		}
	}

	static Subtract(a, b) { 
		if (b is Num) {
			return Vector.new(a.x - b, a.y - b)
		} else {
			return Vector.new(a.x - b.x, a.y - b.y)
		}
	}

	static Multiply(a, b) { 
		if (b is Num) {
			return Vector.new(a.x * b, a.y * b)
		} else {
			return Vector.new(a.x * b.x, a.y * b.y)
		}
	}

	static Divide(a, b) { 
		if (b is Num) {
			return Vector.new(a.x / b, a.y / b)
		} else {
			return Vector.new(a.x / b.x, a.y / b.y)
		}
	}

	// static Cross(a, b) {}

	static RotationTo(a, b) {
        return a.rotationTo(b)
	}

	static Degrees(radian_vector) { 
        return radian_vector.clone().degrees()
	}

	static Radians(degree_vector) { 
        return degree_vector.clone().radians()
	}


	+(other) {
		if (other is Num) {
			return Vector.new(x + other, y + other)
		} else {
			return Vector.new(x + other.x, y + other.y)
		}
	}

	-(other) {
		if (other is Num) {
			return Vector.new(x - other, y - other)
		} else {
			return Vector.new(x - other.x, y - other.y)
		}
	}

	*(other) {
		if (other is Num) {
			return Vector.new(x * other, y * other)
		} else {
			return Vector.new(x * other.x, y * other.y)
		}
	}

	/(other) {
		if (other is Num) {
			return Vector.new(x / other, y / other)
		} else {
			return Vector.new(x / other.x, y / other.y)
		}
	}

	%(other) {
		if (other is Num) {
			return Vector.new(x % other, y % other)
		} else {
			return Vector.new(x % other.x, y % other.y)
		}
	}

	- {
		return Vector.new(-x, -y)
	}

}
