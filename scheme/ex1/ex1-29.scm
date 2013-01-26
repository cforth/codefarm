#!/bin/guile -s
!#

;高阶函数抽象，过程做参数，求和公式
(define (inc x)
	(+ x 1))

(define (cube x)
	(* x x x))

(define (sum term a next b)
	(if (> a b)
		0
		(+ (term a)
			(sum term (next a) next b))))

;求积分
(define (integral f a b dx)
	(define (add-dx x) (+ x dx))
	(* (sum f (+ a (/ dx 2.0)) add-dx b)
		dx))


;测试用例
(display (integral cube 0 1 0.1))
(newline)
(display (integral cube 0 1 0.01))
(newline)


;辛普森规则求积分
(define (simpson f a b n)
	(define h (/ (- b a) n))
	(define (y k)
		(f (+ a (* k h))))
	(define (term k)
		(* (y k) 
			(cond ((or (= k 0) (= k n)) 1)
				((odd? k) 4.0)
				(else 2.0))))
	(* (/ h 3.0) (sum term 0 inc n)))


;测试用例
(display (simpson cube 0 1 10))
(newline)
(display (simpson cube 0 1 100))
(newline)
