#!/bin/guile -s
!#

;Church计数
(define zero 
	(lambda (f)
		(lambda (x) x)))

(define (add-1 n)
	(lambda (f)
		(lambda (x)
			(f ((n f) x)))))

;根据代换求值(add-1 zero)来定义one

;	(add-1 zero)	;->
;	(add-1 (lambda (f) (lambda (x) x)))	;->
;	(lambda (f) 
;		(lambda (x) (f ((lambda (x) x) x))))	;->
;	(lambda (f)
;		(lambda (x) (f x)))

(define one
	(lambda (f)
		(lambda (x) (f x))))

;根据代换求值(add-1 one)来定义two

;	(add-1 one)	;->
;	(add-1 (lambda (f) (lambda (x) (f x))))	;->
;	(lambda (f)	
;		(lambda (x) (f ((lambda (x) (f x)) x))))	;->
;	(lambda (f)
;		(lambda (x) (f (f x))))

(define two
	(lambda (f)
		(lambda (x) (f (f x)))))

;定义加法运算

(define (new-add a b)
	(lambda (f)
		(lambda (x)
			(f (((a b) f) x)))))

;定义(a b)
;(one two)

;	(one two)	;->
;	((lambda (f) (lambda (x) (f x))) two)	;->
;	(lambda (x) (two x))	:->
;	(lambda (z) ((lambda (f) (lambda (x) (f (f x)))) z))	;->
;	(lambda (z) (lambda (x) (z (z x))))

;(new-add one two) 得到 three

;	(new-add one two)	;->
;	(lambda (f)
;		(lambda (x)
;			(f (((one two) f) x))))	;->
;	(lambda (f)
;		(lambda (x)
;			(f (((lambda (z) (lambda (x) (z (z x))) f) x)))))	;->
;	(lambda (f)
;		(lambda (x)
;			(f ((lambda (x) (f (f x))) x))))	;->
;	(lambda (f)
;		(lambda (x) (f (f (f x)))))

;由此可以推导出three的定义，显示加法运算是正确的

(define three
	(lambda (f)
		(lambda (x) (f (f (f x))))))


