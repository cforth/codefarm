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

;将hanoi算法的结果以序列形式返回,以序列中每两个组成一个操作对，中间步骤，用于后面生成汉诺塔游戏自动移塔动作。
(define (hanoi-list n)
    (let ((lst '())
          (count 0))
         (define (dohanoi-l n to from using)
            (if (> n 0)
                (begin
                    (dohanoi-l (- n 1) using from to)
                    (if (null? lst)
                        (set! lst (list from to))
                        (set! lst (append lst (list from to))))
                    (set! count (+ count 1))
                    (dohanoi-l (- n 1) to using from)
                    #t)
                #f))
          (begin
            (dohanoi-l n 3 1 2)
            (display count)
            (newline)
            (display lst))))

;从键盘接收hanoi塔层数level
(display "请输入hanoi塔层数:")
(define level (read))
(hanoi-list level)
(newline)
(hanoi level)
(newline)
