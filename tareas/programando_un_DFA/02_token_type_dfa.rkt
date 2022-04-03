#|
    Simple implementation of a Deterministic Finite Automaton used to validate input strings
    Identify and return all token types in the input string

    Miguel Arriaga

    Examples:
    (automaton-2 (dfa-str 'start '(int var float comment) delta-arithmetic-1) "a = 32.4 *-8.6 - b/      6.1E-8")
    (automaton-2 (dfa-str 'start '(int var float comment) delta-arithmetic-1) "d = a ^ b+5 // Esto es un comentario")
|#

#lang racket

(require racket/trace)
(provide automaton-2)
(provide arithmetic-lexer)

(struct dfa-str (initial-state accept-states spaces transitions))

(define (arithmetic-lexer string)
    "Main function that calls the automaton and lexes a string"
    (automaton-2 (dfa-str 'start '(int var float comment exp) '(o_sp n_sp) delta-arithmetic-1) string))

(define (automaton-2 dfa input-string)
    "Evaluate a string to validate or not according to a DFA.
    Return a list of tokens found"
    (trace-let loop 
        (
            [state (dfa-str-initial-state dfa)]    ;Current state
            ; [currTokenValue null]
            [chars (string->list input-string)]    ;List of characters
            [result null]                          ;List of tokens found
        )                         
        (if (empty? chars)
            ; Check that the final state is in he accept states list
            (if (member state (dfa-str-accept-states dfa))
                (reverse (cons state result))
                (if (member state (dfa-str-spaces dfa))
                    (reverse result)
                    #f
                )
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
    (member char '(#\+ #\- #\* #\^ #\=)))

(define (division? char)
    (member char '(#\/)))

(define (sign? char)
    (member char '(#\+ #\-)))

(define (space? char)
    (member char '(#\space)))

(define (dot? char)
    (member char '(#\.)))

(define (exp? char)
    (member char '(#\e #\E)))

(define (delta-arithmetic-1 state character)
    "Transition function for an automaton that accepts basic arithmetic operations"
    (case state
        ['start (cond
                    [(char-numeric? character) (values #f 'int)]
                    [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
                    [(sign? character) (values #f 'n_sign)]
                    [(space? character) (values #f 'o_sp)]
                    [else (values #f 'fail)])]
        ['n_sign (cond
                    [(char-numeric? character) (values #f 'int)]
                    [else (values #f 'fail)])]
        ['int (cond
                    [(char-numeric? character) (values #f 'int)]
                    [(operator? character) (values 'int 'op)]
                    [(division? character) (values 'int 'div)]
                    [(space? character) (values 'int 'n_sp)]
                    [(dot? character) (values #f 'float)]
                    [(exp? character) (values #f 'exp_pow)]
                    [else (values #f 'fail)])]
        ['float (cond
                    [(char-numeric? character) (values #f 'float)]
                    [(operator? character) (values 'float 'op)]
                    [(division? character) (values 'float 'div)]
                    [(space? character) (values 'float 'n_sp)]
                    [(exp? character) (values #f 'exp_pow)]
                    [else (values #f 'fail)])]
        ['exp_pow (cond
                    [(char-numeric? character) (values #f 'exp)]
                    [(sign? character) (values #f 'exp)]
                    [else (values #f 'fail)])]
        ['exp (cond
                    [(char-numeric? character) (values #f 'exp)]
                    [(operator? character) (values 'exp 'op)]
                    [(division? character) (values 'exp 'div)]
                    [(space? character) (values 'exp 'n_sp)]
                    [else (values #f 'fail)])]
        ['var (cond
                    [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
                    [(char-numeric? character) (values #f 'var)]
                    [(operator? character) (values 'var 'op)]
                    [(division? character) (values 'var 'div)]
                    [(space? character) (values 'var 'n_sp)]
                    [else (values #f 'fail)])]
        ['op (cond
                    [(char-numeric? character) (values 'op 'int)]
                    [(sign? character) (values 'op 'n_sign)]
                    [(or (char-alphabetic? character) (eq? character #\_)) (values 'op 'var)]
                    [(space? character) (values 'op 'o_sp)]
                    ; [(dot? character) (values #f 'float)]
                    [else (values #f 'fail)])]
        ['div (cond
                    [(char-numeric? character) (values 'op 'int)]
                    [(sign? character) (values 'op 'n_sign)]
                    [(or (char-alphabetic? character) (eq? character #\_)) (values 'op 'var)]
                    [(space? character) (values 'op 'o_sp)]
                    ; [(dot? character) (values #f 'float)]
                    [(division? character) (values #f 'comment)]
                    [else (values #f 'fail)])]
        ['comment (cond
                    [else (values #f 'comment)])]
        ['o_sp (cond
                    [(char-numeric? character) (values #f 'int)]
                    ; [(dot? character) (values #f 'float)]
                    [(sign? character) (values #f 'n_sign)]
                    [(space? character) (values #f 'o_sp)]
                    [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
                    [else (values #f 'fail)])]
        ['n_sp (cond
                    [(operator? character) (values #f 'op)]
                    [(division? character) (values #f 'div)]
                    [(space? character) (values #f 'n_sp)]
                    [else (values #f 'fail)])]
        ['fail (values #f 'fail)]
    )
)

