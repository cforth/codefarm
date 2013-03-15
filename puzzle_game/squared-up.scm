#!/bin/guile -s
!#

;构造顺序矩阵
(define (make-matrix wide)
    (define (make-list start end)
        (define (make-list-iter start end result)
            (if (> start end)
                result
                (make-list-iter start (- end 1) (cons end result))))
        (make-list-iter start end '()))
    (define (make-matrix-iter wide high result)
        (let ((start (+ (* (- high 1) wide) 1))
              (end (* high wide)))
             (if (< high 1)
                 result
                 (make-matrix-iter wide (- high 1) (cons (make-list start end) result)))))
    (make-matrix-iter wide wide '()))

;打印顺序矩阵
(define (print-matrix matrix)
    (define (print-list lst)
        (if (null? lst)
            #f
            (begin
                (display (car lst))
                (display "\t")
                (print-list (cdr lst)))))
    (if (null? matrix)
        #f
        (begin
            (print-list (car matrix))
            (newline)
            (print-matrix (cdr matrix)))))

;求顺序矩阵第X行，第Y列的数值，行列数以1为初始值
(define (value-matrix matrix x y)
    (list-ref (list-ref matrix (- x 1)) (- y 1)))


;通过表格构造矩阵
;二维表格,创建局部表格,以same-key?过程作为参数
(define (make-table same-key?)
    (let ((local-table (list '*table*)))
         (define (assoc-t key records)
            (cond ((null? records) #f)
                  ((same-key? key (caar records)) (car records))
                  (else (assoc-t key (cdr records)))))
         (define (lookup key-1 key-2)
            (let ((subtable (assoc-t key-1 (cdr local-table))))
                 (if subtable
                     (let ((record (assoc-t key-2 (cdr subtable))))
                          (if record
                              (cdr record)
                              #f))
                      #f)))
         (define (insert! key-1 key-2 value)
            (let ((subtable (assoc-t key-1 (cdr local-table))))
                 (if subtable
                     (let ((record (assoc-t key-2 (cdr subtable))))
                          (if record
                              (set-cdr! record value)
                              (set-cdr! subtable
                                        (cons (cons key-2 value)
                                              (cdr subtable)))))
                     (set-cdr! local-table
                               (cons (list key-1
                                           (cons key-2 value))
                                     (cdr local-table)))))
             'ok)
         (define (dispatch m)
            (cond ((eq? m 'lookup-proc) lookup)
                  ((eq? m 'insert-proc!) insert!)
                  (else (error "Unknown operation -- TABLE" m))))
         dispatch))


;测试,关键码用equal?比较
(define table1 (make-table equal?))

(define get1 (table1 'lookup-proc))

(define put1 (table1 'insert-proc!))





;测试
(display (list-ref (list-ref '((1 2) 2 3 4) 0) 0))
(newline)
(define x (make-matrix 4))
(display x)
(newline)
(print-matrix x)
(display (value-matrix x 3 2))
(newline)
