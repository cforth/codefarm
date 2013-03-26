#!/bin/guile -s
!#

;反门
(define (inverter input output)
    (define (invert-input)
        (let ((new-value (logical-not (get-signal input))))
            (after-delay inverter-delay
                         (lambda ()
                            (set-signal! output new-value)))))
    (add-action! input invert-input)
    'ok)

(define (logical-not s)
    (cond ((= s 0) 1)
          ((= s 1) 0)
          (else (error "Invalid signal" s))))

;与门
(define (and-gate a1 a2 output)
    (define (and-action-procedure)
        (let ((new-value
                (logical-and (get-signal a1) (get-signal a2))))
            (after-delay and-gate-delay
                         (lambda ()
                            (set-signal! output new-value)))))
    (add-action! a1 and-action-procedure)
    (add-action! a2 and-action-procedure)
    'ok)

(define (logical-and s1 s2)
    (cond ((and (= s1 0) (= s2 0)) 0)
          ((and (= s1 1) (= s2 0)) 0)
          ((and (= s1 0) (= s2 1)) 0)
          ((and (= s1 1) (= s2 1)) 1)
          (else (error "Invalid signal" s1 s2))))


;或门,另一种方法,对于电子工程专业的我来说，易如反掌
;
;   a -->*inverter*-->
;                    |
;                    |-->*and-gate*-->*inverter*--> output
;                    |
;   b -->*inverter*-->
;
;
(define (or-gate a b output)
    (let ((a1 (make-wire))
          (b1 (make-wire))
          (c1  (make-wire)))
        (inverter a a1)
        (inverter b b1)
        (and-gate a1 b1 c1)
        (inverter c1 output)
        'ok))

;or-gate-delay 
(define (or-gate-delay)
    (+ inverter-delay and-gate-delay inverter-delay))
