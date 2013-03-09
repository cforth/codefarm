#!/bin/guile -s
!#

;一维表格
(define (lookup key table)
    (let ((record (assoc-t key (cdr table))))
         (if record
             (cdr record)
             #f)))

(define (assoc-t key records)
    (cond ((null? records) #f)
          ((equal? key (caar records)) (car records))
          (else (assoc-t key (cdr records)))))

(define (insert! key value table)
    (let ((record (assoc-t key (cdr table))))
         (if record
            (set-cdr! record value)
            (set-cdr! table
                      (cons (cons key value) (cdr table))))))

(define (make-table)
    (list '*table*))

(define t1 (make-table))
(insert! 'a 1 t1)
(insert! 'b 2 t1)
(insert! 'c 3 t1)
(display (lookup 'a t1))
(newline)
(display (lookup 'b t1))
(newline)
(display (lookup 'c t1))
(newline)
(display (lookup 'd t1))
(newline)


;二维表格,创建局部表格
(define (make-2d-table)
    (let ((local-table (list '*table*)))
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


(define operation-table (make-2d-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put 'math '+ 43)
(put 'math '- 45)
(put 'math '* 42)
(put 'letters 'a 97)
(put 'letters 'b 98)
(display (get 'math '+))
(newline)
(display (get 'math '-))
(newline)
(display (get 'math '*))
(newline)
(display (get 'letters 'a))
(newline)
(display (get 'letters 'b))
(newline)
(display (get 'letters 'c))
(newline)
