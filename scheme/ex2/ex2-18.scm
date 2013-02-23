#!/bin/guile -s
!#

;反转序列
(define (reverse1 lst)
    (define (iter result lst)
        (if (null? lst)
            result
            (iter (cons (car lst) result)
                  (cdr lst))))
    (iter '() lst))


;测试
(display (reverse1 '(1 2 3 4 5 6 7 8)))
(newline)
(display (reverse1 '()))
(newline)
