/*
| a | c | tx |
| b | d | ty |
| 0 | 0 | 1  |
 */

class AffineTransform {

	construct new() {
		_a = 1
		_b = 0
		_c = 0
		_d = 1
		_tx = 0
		_ty = 0
	}

	construct new(a, b, c, d, tx, ty) {
		_a = a
		_b = b
		_c = c
		_d = d
		_tx = tx
		_ty = ty
	}

	a { _a } 
	a=(v) { _a = v } 

	b { _b } 
	b=(v) { _b = v } 
	
	c { _c } 
	c=(v) { _c = v } 
	
	d { _d } 
	d=(v) { _d = v } 
	
	tx { _tx } 
	tx=(v) { _tx = v } 
	
	ty { _ty } 
	ty=(v) { _ty = v } 

	identity() {
		set(
			1, 0,
			0, 1,
			0, 0
		)

		return this
	}

	set(a, b, c, d, tx, ty) {
		_a = a
		_b = b
		_c = c
		_d = d
		_tx = tx
		_ty = ty

		return this
	}

	translate(x, y) {
		_tx = _tx + x
		_ty = _ty + y

		return this
	}    

	prependTranslate(x, y) {
		_tx = _a * x + _c * y + _tx
		_ty = _b * x + _d * y + _ty

		return this
	}
	
	scale(x, y) {
		_a = _a * x
		_b = _b * x
		_c = _c * y
		_d = _d * y

		return this
	}

	// https.com/yoshihitofujiwara/INKjs/blob/master/src/class_geometry/Matrix2.js
	shear(x, y) {
		var cy = y.cos
		var sy = y.sin
		var sx = -x.sin
		var cx = x.cos

		var a1 = _a
		var b1 = _b
		var c1 = _c
		var d1 = _d

		_a = (cy * a1) + (sy * c1)
		_b = (cy * b1) + (sy * d1)
		_c = (sx * a1) + (cx * c1)
		_d = (sx * b1) + (cx * d1)

		return this
	}
	
	rotate(radians) {
		var sin = radians.sin
		var cos = radians.cos

		var a1 = _a
		var b1 = _b
		var c1 = _c
		var d1 = _d

		_a = a1 *  cos + b1 * sin
		_b = a1 * -sin + b1 * cos
		_c = c1 *  cos + d1 * sin
		_d = c1 * -sin + d1 * cos

		return this
	}

	append(m) {
        var a1 = _a
        var b1 = _b
        var c1 = _c
        var d1 = _d

        _a = m.a * a1 + m.b * c1
        _b = m.a * b1 + m.b * d1
        _c = m.c * a1 + m.d * c1
        _d = m.c * b1 + m.d * d1

        _tx = m.tx * a1 + m.ty * c1 + _tx
        _ty = m.tx * b1 + m.ty * d1 + _ty

		return this
	}

	prepend(m) {
	    if (m.a != 1 || m.b != 0 || m.c != 0 || m.d != 1) {
	        var a1 = _a
	        var c1 = _c

	        _a = a1 * m.a + _b * m.c
	        _b = a1 * m.b + _b * m.d
	        _c = c1 * m.a + _d * m.c
	        _d = c1 * m.b + _d * m.d
	    }

	    var tx1 = _tx
	    _tx = tx1 * m.a + _ty * m.c + m.tx
	    _ty = tx1 * m.b + _ty * m.d + m.ty

	    return this
	}

	orto(left, right, bottom, top) {
		var sx = 1.0 / (right - left)
		var sy = 1.0 / (top - bottom)

		set(
			2.0*sx,      0,
			0,           2.0*sy,
			-(right+left)*sx, -(top+bottom)*sy
		)

		return this
	}

	invert() {
		var a1 = _a
		var b1 = _b
		var c1 = _c
		var d1 = _d
		var tx1 = _tx
		var n = a1 * d1 - b1 * c1

		_a = d1 / n
		_b = -b1 / n
		_c = -c1 / n
		_d = a1 / n
		_tx = (c1 * ty - d1 * tx1) / n
		_ty = -(a1 * ty - b1 * tx1) / n

		return this
	}

	copyFrom(other) {
		set(
			other.a,  other.b,
			other.c,  other.d,
			other.tx, other.ty
		)

		return this
	}

	clone() {
		return AffineTransform.new(_a, _b, _c, _d, _tx, _ty)
	}

	getTransformX(x, y) {
		return _a * _x + _c * _y + _tx
	}

	getTransformY(x, y) {
		return _b * _x + _d * _y + _ty
	}

	setTransform(x, y, angle, sx, sy, ox, oy, kx, ky) {
		var sin = angle.sin
		var cos = angle.cos

		_a = cos * sx - ky * sin * sy
		_b = sin * sx + ky * cos * sy
		_c = kx * cos * sx - sin * sy
		_d = kx * sin * sx + cos * sy
		_tx = x - ox * _a - oy * _c
		_ty = y - ox * _b - oy * _d
		
		return this
	}
}
