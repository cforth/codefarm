#!/bin/guile -s
!#

;利用局部状态构造的队列
(define (make-queue)
    (let ((front-ptr '())
          (rear-ptr '()))
    (define (empty-queue?)
        (null? front-ptr))
    (define (front-queue)
        (if (empty-queue?)
            (error "FRONT called with empty queue")
            (car front-ptr)))
    (define (insert-queue! item)
        (let ((new-pair (cons item '())))
             (cond ((empty-queue?) 
                    (begin
                        (set! front-ptr new-pair)
                        (set! rear-ptr new-pair)))
                   (else
                    (set-cdr! rear-ptr new-pair)
                    (set! rear-ptr new-pair)))))
    (define (delete-queue!)
        (cond ((empty-queue?) (error "DELETE! called on emtpy queue"))
              (else
                (set! front-ptr (cdr front-ptr)))))
    (define (print-queue)
        front-ptr)
    (define (dispatch m)
        (cond ((eq? m 'empty-queue?) empty-queue?)
              ((eq? m 'insert-queue!) insert-queue!)
              ((eq? m 'delete-queue!) delete-queue!)
              ((eq? m 'front-queue) front-queue)
              ((eq? m 'print-queue) print-queue)
              (else (error "ERR"))))
    dispatch))

;测试
(define q1 (make-queue))

(display ((q1 'print-queue)))
(newline)

((q1 'insert-queue!) 5)
(newline)

(display ((q1 'print-queue)))
(newline)

((q1 'delete-queue!))
(newline)

(display ((q1 'print-queue)))
(newline)

((q1 'insert-queue!) 4)
(newline)

(display ((q1 'print-queue)))
(newline)

((q1 'insert-queue!) 3)
(newline)

(display ((q1 'print-queue)))
(newline)

((q1 'insert-queue!) 2)
(newline)

(display ((q1 'print-queue)))
(newline)

((q1 'insert-queue!) 1)
(newline)

(display ((q1 'print-queue)))
(newline)

