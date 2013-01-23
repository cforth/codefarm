#!/bin/guile -s
!#

;make-segment
;构造平面上的线段，用一对点表示
(define (make-segment p1 p2)
	(cons p1 p2))

(define (start-segment seg)
	(car seg))

(define (end-segment seg)
	(cdr seg))

(define (make-point x y)
	(cons x y))

(define (x-point p) 
	(car p))

(define (y-point p) 
	(cdr p))

(define (print-point p)
	(newline)
	(display "(")
	(display (x-point p))
	(display " , ")
	(display (y-point p))
	(display ")"))

(define (midpoint-segment seg)
	(let (	(sp (start-segment seg))
			(ep (end-segment seg)))
		(let (	(mp-x (/ (+ (x-point sp) (x-point ep)) 2))
				(mp-y (/ (+ (y-point sp) (y-point ep)) 2)))
			(make-point mp-x mp-y))))


;测试
(define seg1 (make-segment (make-point -1 -1) (make-point 1 2)))
(print-point (midpoint-segment seg1))
(newline)
