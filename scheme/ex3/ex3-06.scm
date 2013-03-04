#!/bin/guile -s
!#

(define (rand m)
    (cond ((eq? m 'generate) (random))
          ((eq? m 'reset) (lambda (seed) (random-seed seed)))))
