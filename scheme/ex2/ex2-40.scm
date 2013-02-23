#!/bin/guile -s
!#

;素数检测
(define (square n)
    (* n n))

(define (divides? a b)
    (= (remainder b a) 0))

(define (prime? num)
    (define (next n)
        (if (= n 2) 3 (+ n 2)))
    (define (find-divisor n test-divisor)
        (cond   ((> (square test-divisor) n) n)
                ((divides? test-divisor n) test-divisor)
                (else (find-divisor n (next test-divisor)))))
    (define (smallest-divisor n)
        (find-divisor n 2))

    (= num (smallest-divisor num)))

;序列操作
(define (filter1 predicate sequence)
    (cond   ((null? sequence) '())
            ((predicate (car sequence))
                (cons   (car sequence)
                        (filter1 predicate (cdr sequence))))
            (else (filter1 predicate (cdr sequence)))))

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
    (if (> low high)
        '()
        (cons low (enumerate-interval (+ low 1) high))))

;嵌套映射,给定自然数n，找出所有不同的有序对i和j，其中1<=j<=i<=n，使得i+j是素数。产生一个三元组(i,j,i+j)构成的序列。
(define (flatmap proc seq)
    (accumulate append '() (map proc seq)))

(define (prime-sum? pair)
    (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
    (map make-pair-sum
            (filter1 prime-sum?
                (flatmap
                    (lambda (i)
                        (map (lambda (j) (list i j))
                             (enumerate-interval 1 (- i 1))))
                    (enumerate-interval 1 n)))))

;使用unique-pairs简化prime-sum-pairs
(define (unique-pairs n)
    (flatmap (lambda (i)
                (map (lambda (j) (list i j))
                    (enumerate-interval 1 (- i 1))))
             (enumerate-interval 2 n)))

(define (prime-sum-pairs2 n)
    (map make-pair-sum
        (filter1 prime-sum?
                    (unique-pairs n))))

;测试
(display (prime-sum-pairs 6))
(newline)
(display (prime-sum-pairs2 6))
(newline)

