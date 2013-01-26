#!/bin/guile -s
!#

;表操作
(define (list-ref-new items n)
	(if (= n 0)
		(car items)
		(list-ref (cdr items) (- n 1))))

(define (length-new items)
	(define (length-iter a count)
		(if (null? a)
			count
			(length-iter (cdr a) (+ 1 count))))
	(length-iter items 0))

(define (last-pair items)
	(list-ref-new items (- (length-new items) 1)))

(define (reverse-new items)
	(define (reverse-iter a l)
		(if (null? a)
			l
			(reverse-iter (cdr a) (cons (car a) l))))
	(reverse-iter items '()))

;测试
(let (	(list1 (list 0 1 2 3 4 5 6 7)))
	(display (list-ref-new list1 2))
	(newline)
	(display (length-new list1))
	(newline)
	(display (reverse-new list1))
	(newline)
	(display (last-pair list1))
	(newline))
