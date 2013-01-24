#!/bin/guile -s
!#

;make-rectangle
;构造平面上的矩形,用两种方法实现矩形

;		    width
;       p1   seg1   p2
;       +-----------+
;seg4   |           |  seg2 height
;       +-----------+
;       p4   seg3   p3

(define (make-point x y)
	(cons x y))

(define (x-point p) 
	(car p))

(define (y-point p) 
	(cdr p))

;使用矩形的四个顶点坐标表示
;(define (make-rectangle p1 p2 p3 p4)
;	(cons p1 (cons p2 (cons p3 p4))))

;(define (rectangle-p1 rect)
;	(car rect))

;(define (rectangle-p2 rect)
;	(car (cdr rect)))

;(define (rectangle-p3 rect)
;	(car (cdr (cdr rect))))

;(define (rectangle-p4 rect)
;	(cdr (cdr (cdr rect))))

;使用矩形对角线一对点的坐标表示
(define (make-rectangle p1 p3)
	(cons p1 p3))

(define (rectangle-p1 rect)
	(car rect))

(define (rectangle-p3 rect)
	(cdr rect))

(define (rectangle-p2 rect)
	(let (	(p1 (rectangle-p1 rect))
			(p3 (rectangle-p3 rect)))
		(let (	(p2-x (x-point p3))
				(p2-y (y-point p1)))
			(make-point p2-x p2-y))))

(define (rectangle-p4 rect)
	(let (	(p1 (rectangle-p1 rect))
			(p3 (rectangle-p3 rect)))
		(let (	(p4-x (x-point p1))
				(p4-y (y-point p3)))
			(make-point p4-x p4-y))))


;求矩形宽度和高度
(define (width-rect rect)
	(let (	(p1 (rectangle-p1 rect))
			(p3 (rectangle-p3 rect)))
		(let (	(p1-x (x-point p1))
				(p3-x (x-point p3)))
			(- p3-x p1-x))))

(define (height-rect rect)
	(let (	(p1 (rectangle-p1 rect))
			(p3 (rectangle-p3 rect)))
		(let (	(p1-y (y-point p1))
				(p3-y (y-point p3)))
			(- p1-y p3-y))))

;求矩形周长和面积
(define (perimeter-rect rect)
	(let (	(width (width-rect rect))
			(height (height-rect rect)))
	(* (+ width height) 2)))

(define (area-rect rect)
	(let (	(width (width-rect rect))
			(height (height-rect rect)))
	(* width height)))

;打印出矩形的四个点坐标
(define (print-point p)
	(newline)
	(display "(")
	(display (x-point p))
	(display " , ")
	(display (y-point p))
	(display ")"))

(define (print-rectangle rect)
	(let (	(p1 (rectangle-p1 rect))
			(p2 (rectangle-p2 rect))
			(p3 (rectangle-p3 rect))
			(p4 (rectangle-p4 rect)))
		(print-point p1)
		(print-point p2)
		(print-point p3)
		(print-point p4)))

;测试
;打印出矩形四个点的坐标，并求出周长和面积
;(define rect1 
;	(make-rectangle 
;		(make-point -1 2) 
;		(make-point 1 2) 
;		(make-point 1 0) 
;		(make-point -1 0)))

(define rect1 
	(make-rectangle 
		(make-point -1 2) 
		(make-point 1 0)))

(print-rectangle rect1)
(newline)
(newline)
(display (perimeter-rect rect1))
(newline)
(display (area-rect rect1))
(newline)

