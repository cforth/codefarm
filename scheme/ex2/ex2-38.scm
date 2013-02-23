#!/bin/guile -s
!#

;正向反向累积操作
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define fold-right1 accumulate)

(define (fold-left1 op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter (op result (car rest))
                  (cdr rest))))
    (iter initial sequence))

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
