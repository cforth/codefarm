#!/bin/guile -s
!#

;接收一个角度作为参数，返回sin函数的值
;角度用弧度描述为：360度 = 2*pi
(define pi 3.1415926)

(define (cube x) (* x x x))

(define (p x) (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
	(define (sine1 radian)
		(if (not (> (abs radian) 0.001))
			radian
			(p (sine1 (/ radian 3.0)))))
	(sine1 (/ (* angle pi) 180)))

;测试代码
(define (test-sine minangle maxangle step)
	(display minangle)
	(display " -> ")
	(display (sine minangle))
	(newline)
	(if (>= minangle maxangle)
		(display "\nTest completed.\n")
		(test-sine (+ minangle step) maxangle step)))

(test-sine 0 360 1)
(newline)
