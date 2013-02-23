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

;反转序列
(define (reverse1 sequence)
    (fold-right1 (lambda (x y) (append y (cons x '()))) '() sequence))

(define (reverse2 sequence)
    (fold-left1 (lambda (x y) (cons y x)) '() sequence))
 

;测试
(display (reverse1 '(1 2 3 4 5 6 7 8)))
(newline)
(display (reverse2 '(1 2 3 4 5 6 7 8)))
(newline)
