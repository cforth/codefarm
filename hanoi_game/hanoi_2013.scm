#!/bin/guile -s
!#

;汉诺塔游戏--scheme实现

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;堆栈模块
(define (front-ptr stack) (car stack))

(define (rear-ptr stack) (cdr stack))

(define (set-front-ptr! stack item) (set-car! stack item))

(define (set-rear-ptr! stack item) (set-cdr! stack item))

(define (empty-stack? stack) (null? (front-ptr stack)))

(define (make-stack) (cons '() '()))

(define (front-stack stack)
    (if (empty-stack? stack)
        (error "FRONT called with an empty stack" stack)
        (car (front-ptr stack))))


(define (push-stack! stack item)
    (let ((new-pair (cons item '())))
        (cond ((empty-stack? stack)
               (set-front-ptr! stack new-pair)
               (set-rear-ptr! stack new-pair)
               stack)
              (else
               (set-cdr! new-pair (front-ptr stack))
               (set-front-ptr! stack new-pair)
               stack))))

(define (pop-stack! stack)
    (cond ((empty-stack? stack)
           (error "POP! called with an empty stack" stack))
          (else
           (set-front-ptr! stack (cdr (front-ptr stack)))
           stack)))

(define (print-stack stack)
    (front-ptr stack))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;汉诺塔模块内部实现

;初始化一个塔
(define (init-hanoi level hanoi)
    (if (= level 0)
        hanoi
        (init-hanoi (- level 1) (push-stack! hanoi level))))

;汉诺塔完成度检测，汉诺塔游戏是否完成？
(define (complete-hanoi? level hanoi)
    (if (= level (length (front-ptr hanoi)))
        #t
        #f))

;汉诺塔移塔规则
(define (can-be-push? hanoi item)
    (if (null? (front-ptr hanoi))
        #t
        (if (> (front-stack hanoi) item)
            #t
            #f)))

(define (can-be-pop? hanoi)
    (if (null? (front-ptr hanoi))
        #f
        #t))

;移动一个塔上的顶圆盘到另一个塔,若无法移动则保持原状态不变。
(define (move-hanoi hanoi-x hanoi-y)
    (if (can-be-pop? hanoi-x)
        (let ((disk (front-stack hanoi-x)))
             (if (can-be-push? hanoi-y disk)
                 (begin
                    (push-stack! hanoi-y disk)
                    (pop-stack! hanoi-x)
                    #t)))
         #f))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;汉诺塔游戏界面
;待完成,因游戏界面的设计思路与C语言版本是一致的，暂时不写了。
;最激动人心的部分，还是scheme实现堆栈操作。后面的汉诺塔内部实现其实用C语言写也是一样的。
;用scheme写汉诺塔游戏，其实就是把C语言写的代码翻译成scheme，没有什么特别的优势。
;2013-3-6    chaif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;测试，汉诺塔雏形
(define h1 (make-stack))

(define h2 (make-stack))

(define h3 (make-stack))

(init-hanoi 3 h1)
(display (print-stack h1))
(display (print-stack h2))
(display (print-stack h3))
(newline)
(newline)

(move-hanoi h2 h1)
(display (print-stack h1))
(display (print-stack h2))
(display (print-stack h3))
(newline)
(newline)

(move-hanoi h1 h3)
(display (print-stack h1))
(display (print-stack h2))
(display (print-stack h3))
(newline)
(newline)

(move-hanoi h1 h2)
(display (print-stack h1))
(display (print-stack h2))
(display (print-stack h3))
(newline)
(newline)

(move-hanoi h3 h2)
(display (print-stack h1))
(display (print-stack h2))
(display (print-stack h3))
(newline)
(newline)

(move-hanoi h1 h3)
(display (print-stack h1))
(display (print-stack h2))
(display (print-stack h3))
(newline)
(newline)

(move-hanoi h2 h1)
(display (print-stack h1))
(display (print-stack h2))
(display (print-stack h3))
(newline)
(newline)

(move-hanoi h2 h3)
(display (print-stack h1))
(display (print-stack h2))
(display (print-stack h3))
(newline)
(newline)

(move-hanoi h1 h3)
(display (print-stack h1))
(display (print-stack h2))
(display (print-stack h3))
(newline)
(newline)

(move-hanoi h1 h3)
(display (print-stack h1))
(display (print-stack h2))
(display (print-stack h3))
(newline)
(newline)

(display (complete-hanoi? 3 h3))
(newline)
(newline)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;