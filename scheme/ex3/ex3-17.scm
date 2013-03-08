#!/bin/guile -s
!#

;对任何数据结构都能正确返回不同序对的个数
(define (find-item item seq)
  (cond ((null? seq) #f)
    ((eq? item (car seq)) #t)
    (else (find-item item (cdr seq)))))

(define (new-count-pairs x)
  (let ((repo '()))
    (define (count-pairs x)
      (if (or (not (pair? x)) (find-item x repo)) 0
      (begin
        (set! repo (cons x repo))
        (+ (count-pairs (car x))
           (count-pairs (cdr x)) 1))))
    (count-pairs x)))



;测试
(display
    (let ((a (list 'a)))
         (let ((b (list a a)))
              (new-count-pairs b))))
(newline)

(display
    (let ((a (cons 10 20)))
         (let ((b (cons a a)))
              (let ((c (cons b b)))
                   (new-count-pairs c)))))
(newline)

(display
(let ((a (list 1 2)))
     (let ((b (cons 10 a)))
          (set-cdr! (cdr a) b)
          (new-count-pairs a))))
(newline)
