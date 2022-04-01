#|
    Simple implementation of a Deterministic Finite Automaton used to validate input strings
    Identify and return all token types in the input string

    Miguel Arriaga

    Examples:
    (automaton-1 (dfa-str 'start '(int var) delta-arithmetic-1) "34+9")
|#

#lang racket

(require racket/trace)

(provide automaton-2)

(struct dfa-str (initial-state accept-states transitions))

(define (automaton-2 dfa input-string)
    "Evaluate a string to validate or not according to a DFA.
    Retirn a list of tokens found"
    (trace-let loop 
        (
            [state (dfa-str-initial-state dfa)]    ;Current state
            [chars (string->list input-string)]    ;List of characters
            [result null]                          ;List of tokens found
        )                         
        (if (empty? chars)
            ; Check that the final state is in he accept states list
            (if (member state (dfa-str-accept-states dfa))
                (reverse (cons state result))
                #f
            )
            ; Recursive loop with the new state and the rest of the list
            (let-values ([(token state) ((dfa-str-transitions dfa) state (car chars))])
                (loop
                    ; Get the new state
                    state
                    ; Call again with the rest of the characters
                    (cdr chars)
                    ; Update the list of tokens found
                    (if token (cons token result) result)
                )
            )
        )
    )
)

(define (operator? char)
    (member char '(#\+ #\- #\* #\/ #\^ #\=)))

(define (sign? char)
    (member char '(#\+ #\-)))

(define (delta-arithmetic-1 state character)
    "Transition function for an automaton that accepts basic arithmetic operations"
    (case state
        ['start (cond
                    [(char-numeric? character) (values #f 'int)]
                    [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
                    [(sign? character) (values #f 'n_sign)]
                    [else (values #f 'fail)])]
        ['n_sign (cond
                    [(char-numeric? character) (values #f 'int)]
                    [else (values #f 'fail)])]
        ['int (cond
                    [(char-numeric? character) (values #f 'int)]
                    [(operator? character) (values 'int 'op)]
                    [else (values #f 'fail)])]
        ['var (cond
                    [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
                    [(char-numeric? character) (values #f 'var)]
                    [(operator? character) (values 'var 'op)]
                    [else (values #f 'fail)])]
        ['op (cond
                    [(char-numeric? character) (values 'op 'int)]
                    [(sign? character) (values 'op 'n_sign)]
                    [(or (char-alphabetic? character) (eq? character #\_)) (values 'op 'var)]
                    [else (values #f 'fail)])]
        ['fail (values #f 'fail)]
    )
)

