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

;或门
(define (or-gate a1 a2 output)
    (define (or-action-procedure)
        (let ((new-value
                (logical-or (get-signal a1) (get-signal a2))))
            (after-delay or-gate-delay
                         (lambda ()
                            (set-signal! output new-value)))))
    (add-action! a1 or-action-procedure)
    (add-action! a2 or-action-procedure)
    'ok)

(define (logical-or s1 s2)
    (cond ((and (= s1 0) (= s2 0)) 0)
          ((and (= s1 1) (= s2 0)) 1)
          ((and (= s1 0) (= s2 1)) 1)
          ((and (= s1 1) (= s2 1)) 1)
          (else (error "Invalid signal" s1 s2))))

;线路的表示
(define (make-wire)
    (let ((signal-value 0) 
          (action-procedures '()))

        (define (set-my-signal! new-value)
            (if (not (= signal-value new-value))
                (begin (set! signal-value new-value)
                       (call-each action-procedures))
                'done))
        
        (define (accept-action-procedure! proc)
            (set! action-procedures (cons proc action-procedures))
            (proc))
        
        (define (dispatch m)
            (cond ((eq? m 'get-signal) signal-value)
                  ((eq? m 'set-signal!) set-my-signal!)
                  ((eq? m 'add-action!) accept-action-procedure)
                  (else (error "Unknown operation -- WIRE" m))))

        dispatch))

;call-each
(define (call-each procedures)
    (if (null? procedures)
        'done
        (begin
            ((car procedures))
            (call-each (cdr procedures)))))

;get-signal,语法糖衣
(define (get-signal wire)
    (wire 'get-signal))

;set-signal
(define (set-signal wire new-value)
    ((wire 'set-signal) new-value))

;add-action!
(define (add-action! wire action-procedure)
    ((wire 'add-action!) action-procedure))

;after-delay
(define (after-delay delays action)
    (add-to-agenda! (+ delays (current-time the-agenda))
                       action
                       the-agenda))

;propagate
(define (propagate)
    (if (empty-agenda? the-agenda)
        'done
        (let ((first-item (first-agenda-item the-agenda)))
            (first-item)
            (remove-first-agenda-item! the-agenda)
            (propagate))))

;测试
(define (probe name wire)
    (add-action! wire
                 (lambda ()
                    (newline)
                    (display name)
                    (display " ")
                    (display (current-time the-agenda))
                    (display "  New-value = ")
                    (display (get-signal wire)))))
