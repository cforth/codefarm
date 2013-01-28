#!/bin/guile -s
!#

;取出下列各表中的7
(define lst1 '(1 3 (5 7) 9))

(display (car (cdr (car (cdr (cdr lst1))))))
(newline)

(define lst2 '((7)))

(display (car (car lst2)))
(newline)

(define lst3 '(1 (2 (3 (4 (5 (6 7)))))))

(display (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr lst3)))))))))))))
(newline)
