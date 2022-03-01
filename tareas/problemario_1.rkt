#| 
Problemario: Programaci´on funcional, parte 1
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
(provide fact-tail-helper)

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

(define (fact-tail-helper num accum)
    "Returns factorial with tail recursion"
    (if (zero? num)
        accum 
        (fact-tail-helper (- num 1) (* num accum))
    )
)

(define (fact-tail num)
    "Calls fact-tail-helper"
    (fact-tail-helper num 1))