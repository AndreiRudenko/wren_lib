class Vector2 {

	construct new() {
		_x = 0
		_y = 0
	}

	construct new(x, y) {
		_x = x
		_y = y
	}

	x { _x } 
	x=(value) { _x = value } 

	y { _y }
	y=(value) { _y = value }

	[i]=(value) {
		if (i == 0) {
			_x = value
		} else if (i == 1) {
			_y = value
		}
		return this
	}

	length=(value) { normalize().multiply(value) }

	angle2D=(value) {
		var len = length
		_y = value.cos * len
		_x = value.sin * len
		return value
	}

	[i] {
		if (i == 0) {
			return _x
		} else if (i == 1) {
			return _y
		} else {
			return null
		}
	}

	length { (x * x + y * y).sqrt }
	lengthSq { x * x + y * y }

	angle2D { _y.atan(_x) }

	inverted { Vector2.new(-_x, -_y) }

	normalized { Vector2.Divide(this, length) }

	copyFrom(other) { 
		_x = other.x
		_y = other.y 
		return this
	}

	set(x, y) { 
		_x = x
		_y = y 
		return this
	}

	lerp(other, t) {
		_x = _x + t * (other.x - _x)
		_y = _y + t * (other.y - _y)
		return this
	}

	int() {
		_x = _x.round
		_y = _y.round
		return this
	}

	equals(value) { 
		return _x == value.x && _y == value.y
	}

	clone() { 
		return Vector2.new(_x, _y)
	}

	normalize() {
		return divide(length)
	}

	dot(other) { 
		return x * other.x + y * other.y
	}

	cross(other) {
		return x * other.y - y * other.x
	}

	distance(other) {
		return ((other.y - y) * (other.y - y) + (other.x - x) * (other.x - x)).sqrt
	}

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

	perpendicular() {
		perpendicular(true)
		return this
	}

	perpendicular(clockwise) {
		if(clockwise) {
			set(y, -x)
		} else {
			set(-y, x)
		}
		return this
	}

	rotationTo(other) { 
		var theta = (other.x - x).atan(other.y - y)
		var r = -(180.0 + (theta * 180.0/Num.pi))
		return r
	}

	rotate(radians) {
		var ca = radians.cos
		var sa = radians.sin
		set(ca * _x - sa * _y, sa * _x + ca * _y)
		return this
	}

	transform(a, b, c, d, tx, ty) {
		set(a * _x + c * _y + tx, b * _x + d * _y + ty)
		return this
	}

	toString { "{ x:%(x), y:%(y) }" }

	static Add(a, b) { 
		if (b is Num) {
			return Vector2.new(a.x + b, a.y + b)
		} else {
			return Vector2.new(a.x + b.x, a.y + b.y)
		}
	}

	static Subtract(a, b) { 
		if (b is Num) {
			return Vector2.new(a.x - b, a.y - b)
		} else {
			return Vector2.new(a.x - b.x, a.y - b.y)
		}
	}

	static Multiply(a, b) { 
		if (b is Num) {
			return Vector2.new(a.x * b, a.y * b)
		} else {
			return Vector2.new(a.x * b.x, a.y * b.y)
		}
	}

	static Divide(a, b) { 
		if (b is Num) {
			return Vector2.new(a.x / b, a.y / b)
		} else {
			return Vector2.new(a.x / b.x, a.y / b.y)
		}
	}

	static Cross(a, b) {
		return a.cross(b)
	}

	static RotationTo(a, b) {
		return a.rotationTo(b)
	}

	static Distance(a, b) {
		return a.distance(b)
	}

	static Degrees(v) { 
		return v.clone().degrees()
	}

	static Radians(v) { 
		return v.clone().radians()
	}

	+(other) {
		if (other is Num) {
			return Vector2.new(_x + other, _y + other)
		} else {
			return Vector2.new(_x + other.x, _y + other.y)
		}
	}

	-(other) {
		if (other is Num) {
			return Vector2.new(_x - other, _y - other)
		} else {
			return Vector2.new(_x - other.x, _y - other.y)
		}
	}

	*(other) {
		if (other is Num) {
			return Vector2.new(_x * other, _y * other)
		} else {
			return Vector2.new(_x * other.x, _y * other.y)
		}
	}

	/(other) {
		if (other is Num) {
			return Vector2.new(_x / other, _y / other)
		} else {
			return Vector2.new(_x / other.x, _y / other.y)
		}
	}

	%(other) {
		if (other is Num) {
			return Vector2.new(_x % other, _y % other)
		} else {
			return Vector2.new(_x % other.x, _y % other.y)
		}
	}

	- {
		return Vector2.new(-_x, -_y)
	}

}
