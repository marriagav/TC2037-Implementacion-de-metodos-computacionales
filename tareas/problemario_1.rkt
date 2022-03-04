#| 
Problemario: Programación funcional, parte 1
Miguel Arriaga
Pablo Rocha
2022-03-04
|#

#lang racket

(provide fahrenheit-to-celsius)
(provide sign)
(provide roots)
(provide bmi)
(provide get-bmi)
(provide factorial)
(provide fact-tail)
(provide !)
(provide duplicate)
(provide pow)
(provide fibo-1)
(provide fibo-2)
(provide enlist)
(provide positives)

; Library to debug function calls
(require racket/trace)

; 1
(define (fahrenheit-to-celsius f)
    "Function that transforms farenheit to celsius"
    (/ (* 5 (- f 32)) 9.0))

; 2
(define (sign number)
    "Return weather a number is positive, negative or zero"
    (if (zero? number) 
        0 
        (if (> number 0)
             1
             -1)))

; 3
(define (roots a b c)
    "Returns solution of cuadrating formula according to the values of a, b and c"
    (/ (- (sqrt (- (expt b 2) (* 4 a c))) b) (* 2 a)))

; 4
(define (get-bmi weight height)
    "Returns BMI of a person"
    (/ weight (expt height 2)))

(define (bmi weight height)
    "Returns BMI description"
    (if (>= (get-bmi weight height) 40)
        'obese3
        (if (>= (get-bmi weight height) 30)
            'obese2
            (if (>= (get-bmi weight height) 25)
                'obese1
                (if (>= (get-bmi weight height) 20)
                'normal 'underweight)))))

;5
(define (factorial num)
    "Returns factorial of a number"
    (if (zero? num) 
        1
        (* num (factorial (- num 1)))
    )
)
;Use only for debugging
;(trace factorial)

(define (fact-tail num)
    "Calls fact-tail-helper"
    (define (fact-tail-helper num accum)
        "Returns factorial with tail recursion"
        (if (zero? num)
            accum 
            (fact-tail-helper (- num 1) (* num accum))
        )
    )
    ;Debug
    ;(trace fact-tail-helper)
    (fact-tail-helper num 1))

(define (! num)
    "Final factorial function implementation, using let"
    (let loop
        ([n num] [a 1])
        (if (zero? n) 
            a
            (loop (- n 1) (* n a)))))

;6
;;; (define (duplicate initial-list) 
;;;     "Duplicate all members in a list"
;;;     (if (null? (cdr initial-list)) 
;;;         (append (car initial-list) (car initial-list))
;;;         (append (car initial-list) (car initial-list) (duplicate (cdr initial-list)))
;;;     )
;;; )

(define (duplicate initial-list) 
    "Duplicate all members in a list"
    (if (null? (cdr initial-list)) 
        (list (car initial-list) (car initial-list))
        (append (list (car initial-list) (car initial-list)) (duplicate (cdr initial-list)))
    )
)

(duplicate '(1 8 3 7))

;7
(define (pow n p) 
    (if (= p 0) 
        1
        (* (pow n (sub1 p)) n)))

;8
(define (fibo-1 n)
    "Returns n fibonacci number"
    (cond
        [(= n 0) 0]
        [(= n 1) 1]
        [else (+ (fibo-1 (- n 1)) (fibo-1 (- n 2)))]))

(define (fibo-2 n)
    "Tail recursion for fibonacci"
    (cond 
        [(= n 0) 0]
        [(= n 1) 1]
        [else (let loop
            ([n (- n 1)] [a 0] [b 1])
            (if (zero? n)
                b
                (loop (sub1 n) b (+ a b))))]))
;9
 (define (enlist initial-list)
    (map (lambda (number)
        (list number))
       initial-list)
 )

;(enlist (list 1 2 3))

;10
(define (positives initial-list) 
    (filter positive? initial-list))

;(positives '(12 -4 3 -1 -10 -13 6 -5))

;11 
  (define (add-list initial-list)
    (if (null? (cdr initial-list)) 
        (car initial-list)
        (+ (car initial-list) (add-list (cdr initial-list))))
 )

;(add-list '(1 8 3))