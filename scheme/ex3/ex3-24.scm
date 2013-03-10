#!/bin/guile -s
!#

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

(put1 'math '+ 43)
(put1 'math '- 45)
(put1 'math '* 42)
(put1 'letters 'a 97)
(put1 'letters 'b 98)
(display (get1 'math '+))
(newline)
(display (get1 'math '-))
(newline)
(display (get1 'math '*))
(newline)
(display (get1 'letters 'a))
(newline)
(display (get1 'letters 'b))
(newline)
(display (get1 'letters 'c))
(newline)

;测试,关键码是数字时，容许误差
(define table2 (make-table (lambda (a b)
                                (cond ((number? a) (if (> 0.5 (abs (- a b))) #t #f))
                                      (else (equal? a b))))))

(define get2 (table2 'lookup-proc))

(define put2 (table2 'insert-proc!))

(put2 'math '+ 43)
(put2 'math '- 45)
(put2 'math '* 42)
(put2 'letters 'a 97)
(put2 'letters 'b 98)
(put2 'a 200 2)
(display (get2 'math '+))
(newline)
(display (get2 'math '-))
(newline)
(display (get2 'math '*))
(newline)
(display (get2 'letters 'a))
(newline)
(display (get2 'letters 'b))
(newline)
(display (get2 'letters 'c))
(newline)
(display (get2 'a 200.4))
(newline)
(display (get2 'a 200.6))
(newline)
