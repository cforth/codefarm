#!/bin/guile -s
!#

;正向反向累积操作
(define (fold-right1 op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (fold-right1 op initial (cdr sequence)))))

(define (fold-left1 op initial sequence)
    (if (null? sequence)
        initial
        (op (fold-left1 op initial (cdr sequence))
            (car sequence))))

;测试
(display (fold-right1 / 1 (list 1 2 3 )))
(newline)
(display (fold-left1 / 1 (list 1 2 3 )))
(newline)
(display (fold-right1 list '() (list 1 2 3)))
(newline)
(display (fold-left1 list '() (list 1 2 3)))
(newline)
(display (fold-right1 + 1 (list 1 2 3 )))
(newline)
(display (fold-left1 + 1 (list 1 2 3 )))
(newline)
(display (fold-right1 * 2 (list 1 2 3 )))
(newline)
(display (fold-left1 * 2 (list 1 2 3 )))
(newline)
