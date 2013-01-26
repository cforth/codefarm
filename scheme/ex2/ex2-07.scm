#!/bin/guile -s
!#

;“区间”算术
(define (make-interval a b)
	(cons a b))

(define (upper-bound x)
	(let (	(x-l (car x))
			(x-r (cdr x)))
		(if (> x-l x-r)
			x-l
			x-r)))

(define (lower-bound x)
	(let (	(x-l (car x))
			(x-r (cdr x)))
		(if (< x-l x-r)
			x-l
			x-r)))

(define (add-interval x y)
	(make-interval (+ (lower-bound x) (lower-bound y))
		(+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
	(make-interval (- (lower-bound x) (upper-bound y))
		(- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
	(let (	(p1 (* (lower-bound x) (lower-bound y)))
			(p2 (* (lower-bound x) (upper-bound y)))
			(p3 (* (upper-bound x) (lower-bound y)))
			(p4 (* (upper-bound x) (upper-bound y))))
		(make-interval (min p1 p2 p3 p4)
			(max p1 p2 p3 p4))))

(define (div-interval x y)
	(let (	(ly (lower-bound y))
			(uy (upper-bound y)))
		(if (and (not (= ly 0)) (not (= uy 0)))
			(mul-interval x
				(make-interval (/ 1.0 ly)
					(/ 1.0 uy)))
			(error "devide by zero!!"))))

;测试
(display (add-interval (make-interval 2 -1) (make-interval 8 5)))
(newline)
(display (sub-interval (make-interval 2 1) (make-interval 8 5)))
(newline)
(display (mul-interval (make-interval 2 -1) (make-interval 8 5)))
(newline)
(display (div-interval (make-interval 2 1) (make-interval 8 5)))
(newline)
(display (div-interval (make-interval 2 1) (make-interval 0 5)))
(newline)
