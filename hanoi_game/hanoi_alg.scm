#!/bin/guile -s
!#

;递归版的hanoi塔算法
(define (dohanoi n to from using)
  (if (> n 0)
      (begin
        (dohanoi (- n 1) using from to)
        (display "move ")
        (display from)
        (display " --> ")
        (display to)
        (newline)
        (dohanoi (- n 1) to using from)
        #t)
      #f))

(define (hanoi n)
    (dohanoi n 3 1 2))


;运行hanoi_alg.scm,输入要求解的汉诺塔层数，摁回车执行。
;hanoi_alg.scm将输出汉诺塔游戏移塔步骤，并将层数与移塔步骤通过管道输给hanoi_auto程序。
;hanoi_auto打印出步骤到屏幕。
;将hanoi算法的结果以序列形式返回,以序列中每两个组成一个操作对，中间步骤，用于后面生成汉诺塔游戏自动移塔动作。
(define (hanoi-list n)
    (let ((lst '()))
         (define (dohanoi-l n to from using)
            (if (> n 0)
                (begin
                    (dohanoi-l (- n 1) using from to)
                    (if (null? lst)
                        (set! lst (list from to))
                        (set! lst (append lst (list from to))))
                    (dohanoi-l (- n 1) to using from)
                    #t)
                #f))
          (begin
            (dohanoi-l n 3 1 2)
            lst)))

;自动运行操作步骤，运行结果通过管道作为hanoi_auto程序的输入，hanoi_auto程序打印出移塔的过程。
(define (auto-move n)
    (let ((lst (hanoi-list n)))
        (define (change-move lst)
            (if (null? (cdr lst))
                '()
                (begin 
                    (display "s")
                    (newline)
                    (cond ((or (and (= (car lst) 1) (= (cadr lst) 2))
                               (and (= (car lst) 2) (= (cadr lst) 3))
                               (and (= (car lst) 3) (= (cadr lst) 1)))
                           (display "d"))
                          ((or (and (= (car lst) 1) (= (cadr lst) 3))
                               (and (= (car lst) 2) (= (cadr lst) 1))
                               (and (= (car lst) 3) (= (cadr lst) 2)))
                           (display "a")))
                    (newline)
                    (change-move (cdr lst)))))
         (change-move lst)))


    

;从键盘接收hanoi塔层数level
(define level (read))
(display level)
(newline)
(auto-move level)
