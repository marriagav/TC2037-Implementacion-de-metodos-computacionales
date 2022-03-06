#| 
Problemario: Programación funcional, parte 1
Miguel Arriaga
Pablo Rocha
2022-03-04
|#

#lang racket
(require racket/trace)

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
(provide fib)
(provide fibo-2)
(provide enlist)
(provide positives)
(provide add-list)
(provide invert-pairs)
(provide list-of-symbols?)
(provide average)
(provide standard-deviation-helper)
(provide standard-deviation)
(provide len)
(provide binary)

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
(define (duplicate initial-list) 
    "Duplicate all members in a list"
    (if (empty? initial-list) 
        '()
    (if (null? (cdr initial-list)) 
        (list (car initial-list) (car initial-list))
        (append (list (car initial-list) (car initial-list)) (duplicate (cdr initial-list)))
    ))
)
;(duplicate '(1 8 3 7))

;7
(define (pow n p) 
    "Returns power p of number n"
    (if (= p 0) 
        1
        (* (pow n (sub1 p)) n)))

;8
(define (fib n)
    "Returns n fibonacci number"
    (cond
        [(= n 0) 0]
        [(= n 1) 1]
        [else (+ (fib (- n 1)) (fib (- n 2)))]))

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
    "Returns a list of lists of the elements in the initial list"
    (map (lambda (number)
        (list number))
       initial-list)
 )
;(enlist (list 1 2 3))

;10
(define (positives initial-list) 
    "Returns a sub-list of the original containing only positives"
    (filter positive? initial-list))
;(positives '(12 -4 3 -1 -10 -13 6 -5))

;11 
(define (add-list lst) 
    "Sum elements in a list"
    (let loop 
    ([lst lst] [result 0])
    (if (empty? lst)
        result
        (loop (cdr lst) (+ (car lst) result))
    )
    )
)
;(add-list '(1 8 3))

;12
(define (invert-pairs initial-list) 
    "Reverse list pairs"
    (if (empty? initial-list) 
        '()
    (if (null? (cdr initial-list)) 
        (list(list (car (cdr (car initial-list))) (car (car initial-list))))
        (append (list (list (car (cdr (car initial-list))) (car (car initial-list)))) (invert-pairs (cdr initial-list)))
    ))
)
;(invert-pairs '((1 2) (3 4) (5 6)))

;13
(define (list-of-symbols? initial-list) 
    "Check if all elements in a list are symbols"
    (if (zero? (length initial-list))
        #t
    (if (null? (cdr initial-list)) 
        (symbol? (car initial-list))
        (and (symbol? (car initial-list)) (list-of-symbols? (cdr initial-list)))
    ))
)
;(list-of-symbols '(a 2 c))

;14
;;; (define (swapper ch1 ch2 initial-list) 
;;;     "Swapps values"
;;;     (if (null? (cdr initial-list)) 
;;;         (if ())
;;;         (+ (car initial-list) (swapper (cdr initial-list))))
;;; )

;16
(define (average initial-list)
    "Get average of list values"
    (if (empty? initial-list) 0 
    (/ (add-list initial-list) (length initial-list))
    ) 
 )
; (average '())


;17 
(define (standard-deviation-helper list1)
    "Obtains a new lista from the original to make standard deviation easier to calculate"
    (let loop
        ([lst list1] [result '()])
        (if (empty? lst)
            (reverse result)
            (loop (cdr lst) (cons (pow (- (car lst) (average list1)) 2) result)))))

(define (len lst)
    "Return the length of a list"
    (if (empty? lst)
    0
    (+ 1 (len (cdr lst)))))

(define (standard-deviation lst)
    "Calculates standard deviation of a list"
    (if (empty? lst) 
        0
    (sqrt (/ (add-list (standard-deviation-helper lst)) (len lst)))))

;20
(define (binary n)
    "Converts an integer to its binary representation"
    (if (zero? n) 
        '()
        (let loop
        ([num n] [result '()])
        (if (zero? num)
            result
            (loop (quotient num 2) (cons (remainder num 2) result))))))