#!/bin/guile -s
!#

;以任意关键码列表作为索引
(define (make-table same-key?)
    (let ((local-table (list '*table*)))
    
         (define (assoc-t key records)
            (cond ((null? records) #f)
                  ((same-key? key (caar records)) (car records))
                  (else (assoc-t key (cdr records)))))

         (define (lookup key-list)
            (define (look-inner key table)
                (let ((subtable (assoc-t (car key) (cdr table))))
                     (if subtable
                         (cond ((null? (cdr key)) (cdr subtable))
                               (else (look-inner (cdr key) subtable)))
                         #f)))
            (look-inner key-list local-table))

         (define (insert! key-list value)
            (define (insert-inner key table)
                (let ((subtable (assoc-t (car key) (cdr table))))
                     (if subtable
                         (cond ((null? (cdr key))  (set-cdr! subtable value))
                               (else (insert-inner (cdr key) subtable)))
                         (begin
                            (if (null? (cdr key)) 
                                       (set-cdr! table (cons (cons  (car key) value) (cdr table)))
                                       (let ((new-subtable (list (car key))))
                                            (set-cdr! table (cons new-subtable (cdr table)))
                                        (insert-inner (cdr key) new-subtable)))))))
           (insert-inner key-list local-table))

         (define (dispatch m)
            (cond ((eq? m 'lookup-proc) lookup)
                  ((eq? m 'insert-proc!) insert!)
                  (else (error "Unknown operation --TABLE"))))

    dispatch))


;测试
(define table (make-table equal?))


(display ((table 'lookup-proc) '(a)))
(newline)

((table 'insert-proc!) '(a b c) 2110)
((table 'insert-proc!) '(a b d) 20)
((table 'insert-proc!) '(a b) 80)
((table 'insert-proc!) '(a c) 80)
((table 'insert-proc!) '(a d e f g) 10)
((table 'insert-proc!) '(a d e f x) 100)
((table 'insert-proc!) '(a d e g h) 40)
(display ((table 'lookup-proc) '(a d e)))
(newline)
(display ((table 'lookup-proc) '(a d e f)))
(newline)
(display ((table 'lookup-proc) '(a d e f)))
(newline)
(display ((table 'lookup-proc) '(a d e g)))
(newline)
