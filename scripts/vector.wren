// ported from https://github.com/underscorediscovery/luxe/blob/master/phoenix/Vector.hx

import "assets/maths" for Maths

class Vector {

	construct new() {
		_x = 0
		_y = 0
	}

	construct new(x,y) {
		_x = x
		_y = y
	}

	x=(value) { _x = value } 
	y=(value) { _y = value }

	[i]=(value) {
		if (i == 0) {
			_x = value
		} else if (i == 1) {
			_y = value
		}
		return this
	}

	length=(value) {
		normalize().multiply(value)
	}

	angle2D=(value) {
		var len = length
		_y = value.cos * len
		_x = value.sin * len
		return value
	}

	x { _x } 
	y { _y }
	
	[i] {
		if (i == 0) {
			return _x
		} else if (i == 1) {
			return _y
		} else {
			return null
		}
	}

	length { 
		return ( x * x + y * y ).sqrt
	}

	lengthsq { 
		return x * x + y * y
	}

	angle2D { 
		return _y.atan(_x)
	}

	inverted { 
		return Vector.new(-_x, -_y) 
	}

	normalized { 
		return Vector.Divide( this, length )
	}

	copy_from(other) { 
		_x = other.x
		_y = other.y 
		return this
	}

	set(x, y) { 
		_x = x
		_y = y 
		return this
	}

	lerp( other, t ) {
		_x = Maths.lerp(_x, other.x, t)
		_y = Maths.lerp(_y, other.y, t)
		return this
	}

	int() {
		_x = Maths.round(_x)
		_y = Maths.round(_y)
		return this
	}

	int_x() {
		_x = Maths.round(_x)
		return this
	}

	int_y() {
		_y = Maths.round(_y)
		return this
	}


	equals(value) { 
		return _x == value.x && _y == value.y
	}

	clone() { 
		return Vector.new(_x, _y)
	}

	normalize() {
		return divide( length )
	}

	dot(other) { 
		return x * other.x + y * other.y
	}

	// cross(other) {
	// 	return x * other.x + y * other.y
	// }

	invert() {
		_x = -_x
		_y = -_y
		return this
	}
	
	add(other) { 
		if (other is Num) {
			_x = _x + other
			_y = _y + other
		} else{
			_x = _x + other.x
			_y = _y + other.y 
		}
		return this
	}

	add(x, y) { 
		_x = _x + x
		_y = _y + y 
		return this
	}

	subtract(other) { 
		if (other is Num) {
			_x = _x - other
			_y = _y - other
		} else{
			_x = _x - other.x
			_y = _y - other.y 
		}
		return this
	}

	subtract(x, y) { 
		_x = _x - x
		_y = _y - y 
		return this
	}

	multiply(other) { 
		if (other is Num) {
			_x = _x * other
			_y = _y * other
		} else{
			_x = _x * other.x
			_y = _y * other.y 
		}
		return this
	}

	multiply(x, y) { 
		_x = _x * x
		_y = _y * y 
		return this
	}

	divide(other) { 
		if (other is Num) {
			_x = _x / other
			_y = _y / other
		} else{
			_x = _x / other.x
			_y = _y / other.y 
		}
		return this
	}

	divide(x, y) { 
		_x = _x / x
		_y = _y / y 
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
		_x = Maths.degrees(_x)
		_y = Maths.degrees(_y)
		return this
	}

	radians() { 
		_x = Maths.radians(_x)
		_y = Maths.radians(_y)
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
			return Vector.new(_x + other, _y + other)
		} else {
			return Vector.new(_x + other.x, _y + other.y)
		}
	}

	-(other) {
		if (other is Num) {
			return Vector.new(_x - other, _y - other)
		} else {
			return Vector.new(_x - other.x, _y - other.y)
		}
	}

	*(other) {
		if (other is Num) {
			return Vector.new(_x * other, _y * other)
		} else {
			return Vector.new(_x * other.x, _y * other.y)
		}
	}

	/(other) {
		if (other is Num) {
			return Vector.new(_x / other, _y / other)
		} else {
			return Vector.new(_x / other.x, _y / other.y)
		}
	}

	%(other) {
		if (other is Num) {
			return Vector.new(_x % other, _y % other)
		} else {
			return Vector.new(_x % other.x, _y % other.y)
		}
	}

	- {
		return Vector.new(-_x, -_y)
	}

}
