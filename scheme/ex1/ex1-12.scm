#!/bin/guile -s
!#

;计算出帕斯卡三角形
;    0 1 2 3 4  x
; 0  1
; 1  1 1
; 2  1 2 1
; 3  1 3 3 1
; 4  1 4 6 4 1 
; y
;
; (x == 0)  =>  1
; (x == y)  =>  1
;
; pascal(3,4) = pascal(3,3) + pascal(2,3)
; pascal(2,3) = pascal(2,2) + pascal(1,2)
; pascal(1,2) = pascal(1,1) + pascal(0,1)

; pascal(x,y) -> x == 0 then 1, x == y then 1
;             -> pascal(x,y-1) + pascal(x-1,y-1)

(define (pascal x y)
	(cond 
		((= x 0) 1)
		((= x y) 1)
		(else (+ (pascal x (- y 1)) (pascal (- x 1) (- y 1))))))

(define (display-pascal n)
	(define (pascal-inner n count)
		(cond 
			((> count n) (display "\n"))
			(else (display (pascal count n))
		  		(display "  ")
				(pascal-inner n (+ 1 count)))))

	(define (pascal-iter n count)
		(cond 
			((= count n) (display "\n"))
			(else (pascal-inner count 0)
				(pascal-iter n (+ count 1)))))
		(pascal-iter n 0))

;代码演示
(display-pascal 10)
