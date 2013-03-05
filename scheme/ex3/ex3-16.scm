#!/bin/guile -s
!#

;错误的方法，统计任何一个表结构中的序对个数
(define (count-pairs x)
    (if (not (pair? x))
        0
        (+ (count-pairs (car x))
           (count-pairs (cdr x))
           1)))


(define x (cons 1 2))
(define y (cons 3 4))
(define z (cons 5 6))

(set-cdr! x y)
(set-cdr! y z)
(set-cdr! z '())

(display x)
(newline)

(display (count-pairs x))
(newline)

;; [+|+]->[+|+]->[+|/]
;;  |      |      |   
;;  1      3      5

;;;;;;;;;;;;;;;;;;;;;;;;;;

(define x (cons 1 2))
(define y (cons 3 4))
(define z (cons 5 6))

(set-cdr! x y)
(set-car! x z)
(set-cdr! y z)
(set-cdr! z '())

(display x)
(newline)

(display (count-pairs x))
(newline)
;; 4

;; [+|+]->[+|+]->[+|/]
;;  |      |      |^
;;  |      3      5|
;;  +--------------+

;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define x (cons 1 2))
(define y (cons 3 4))
(define z (cons 5 6))

(set-car! x y)
(set-cdr! x y)
(set-car! y z)
(set-cdr! y z)

(display x)
(newline)

(display (count-pairs x))
(newline)
;; 7

;; [+|+]
;;  | | 
;; [+|+]
;;  | | 
;; [+|+]
;;  | |
;;  5 6

;;;;;;;;;;;;;;;;;;;;;;;;;
(define x (cons 1 2))

(set-cdr! x x)

;;(count-pairs x)
