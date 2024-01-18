/*
 * _float.h
 *
 *  Created on: Oct 1, 2023
 *      Author: ADMIN
 */

#ifndef INC__FLOAT_H_
#define INC__FLOAT_H_

class _float {
	float number;

public:
	_float(float f);
	operator float();

	static _float Ln();
	static _float Exp();

	static _float Inf();
	static _float QNan();
	static _float SNan();
	static _float Hex(uint32_t);

	void operator-= (_float);
	void operator+= (_float);

	void operator*= (_float);
	void operator/= (_float);

	friend _float operator- (_float, _float);
	friend _float operator+ (_float, _float);

	friend _float operator* (_float, _float);
	friend _float operator/ (_float, _float);

	friend _float operator- (_float);
	friend _float operator+ (_float);

	friend bool operator< (_float, _float);
	friend bool operator> (_float, _float);

	friend bool operator<= (_float, _float);
	friend bool operator>= (_float, _float);

	friend bool operator== (_float, _float);
	friend bool operator!= (_float, _float);
};

#endif /* INC__FLOAT_H_ */
