#!/bin/guile -s
!#

;
(define (make-monitored f)
    (let ((count 0))
         (define (mf cmd)
            (cond ((eq? cmd 'how-many-calls?) count)
                  ((eq? cmd 'reset-count) (set! count 0))
                  (else
                    (set! count (+ 1 count))
                    (f cmd))))
         mf))


(define s (make-monitored sqrt))

(display (s 100))
(newline)
(display (s 'how-many-calls?))
(newline)
(display (s 21))
(newline)
(display (s 'how-many-calls?))
(newline)
(display (s 'how-many-calls?))
(newline)

(display (s 'reset-count))
(newline)
(display (s 100))
(newline)
(display (s 'how-many-calls?))
(newline)
