#!/bin/guile -s
!#

;递归版的hanoi塔算法
(define (dohanoi n to from using)
  (if (> n 0)
      (begin
        (dohanoi (- n 1) using from to)
        (display "move ")
        (display from)
        (display " --> ")
        (display to)
        (newline)
        (dohanoi (- n 1) to using from)
        #t)
      #f))

(define (hanoi n)
    (dohanoi n 3 1 2))

(hanoi 3)
