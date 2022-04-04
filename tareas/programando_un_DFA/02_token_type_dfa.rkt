#|
    Simple implementation of a Deterministic Finite Automaton used to validate input strings
    Identify and return all token types in the input string

    Miguel Arriaga

    Examples:
    (arithmetic-lexer "a = 32.4 *-8.6 - b/      6.1E-8")
    (arithmetic-lexer "d = a ^ b+5 // Esto es un comentario")
    (arithmetic-lexer "d = (a ^ b)+5+5.0e4 // Esto es un comentario")
|#

#lang racket

(require racket/trace)
(provide automaton-2)
(provide arithmetic-lexer)

(struct dfa-str (initial-state accept-states spaces transitions))

(define (arithmetic-lexer string)
    "Main function that calls the automaton and lexes a string"
    (automaton-2 (dfa-str 'start '(int var float comment exp par_close) '(o_sp n_sp) delta-arithmetic-1) string))

(define (automaton-2 dfa input-string)
    "Evaluate a string to validate or not according to a DFA.
    Return a list of tokens found"
    (let loop 
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

(define (par_open? char)
    (member char (list(integer->char 40))))

(define (par_close? char)
    (member char (list(integer->char 41))))

(define (delta-arithmetic-1 state character)
    "Transition function for an automaton that accepts basic arithmetic operations"
    (case state
        ['start (cond
                    [(char-numeric? character) (values #f 'int)]
                    [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
                    [(sign? character) (values #f 'n_sign)]
                    [(space? character) (values #f 'o_sp)]
                    [(par_open? character) (values #f 'par_open)]
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
                    [(par_open? character) (values 'int 'par_open)]
                    [(par_close? character) (values 'int 'par_close)]
                    [else (values #f 'fail)])]
        ['float (cond
                    [(char-numeric? character) (values #f 'float)]
                    [(operator? character) (values 'float 'op)]
                    [(division? character) (values 'float 'div)]
                    [(space? character) (values 'float 'n_sp)]
                    [(exp? character) (values #f 'exp_pow)]
                    [(par_open? character) (values 'float 'par_open)]
                    [(par_close? character) (values 'float 'par_close)]
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
                    [(par_open? character) (values 'exp 'par_open)]
                    [(par_close? character) (values 'exp 'par_close)]
                    [else (values #f 'fail)])]
        ['var (cond
                    [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
                    [(char-numeric? character) (values #f 'var)]
                    [(operator? character) (values 'var 'op)]
                    [(division? character) (values 'var 'div)]
                    [(space? character) (values 'var 'n_sp)]
                    [(par_open? character) (values 'var 'par_open)]
                    [(par_close? character) (values 'var 'par_close)]
                    [else (values #f 'fail)])]
        ['op (cond
                    [(char-numeric? character) (values 'op 'int)]
                    [(sign? character) (values 'op 'n_sign)]
                    [(or (char-alphabetic? character) (eq? character #\_)) (values 'op 'var)]
                    [(space? character) (values 'op 'o_sp)]
                    [(par_open? character) (values 'op 'par_open)]
                    [(par_close? character) (values 'op 'par_close)]
                    [else (values #f 'fail)])]
        ['div (cond
                    [(char-numeric? character) (values 'op 'int)]
                    [(sign? character) (values 'op 'n_sign)]
                    [(or (char-alphabetic? character) (eq? character #\_)) (values 'op 'var)]
                    [(space? character) (values 'op 'o_sp)]
                    [(division? character) (values #f 'comment)]
                    [(par_open? character) (values 'op 'par_open)]
                    [(par_close? character) (values 'op 'par_close)]
                    [else (values #f 'fail)])]
        ['par_open (cond
                    [(char-numeric? character) (values 'par_open 'int)]
                    [(sign? character) (values 'par_open 'n_sign)]
                    [(or (char-alphabetic? character) (eq? character #\_)) (values 'par_open 'var)]
                    [(par_open? character) (values 'par_open 'par_open)]
                    [(par_close? character) (values 'par_open 'par_close)]
                    [(space? character) (values 'par_open 'o_sp)]
                    [else (values #f 'fail)])]
        ['par_close (cond
                    [(operator? character) (values 'par_close 'op)]
                    [(par_open? character) (values 'par_close 'par_open)]
                    [(par_close? character) (values 'par_close 'par_close)]
                    [(space? character) (values 'par_close 'n_sp)]
                    [(division? character) (values 'par_close 'div)]
                    [else (values #f 'fail)])]
        ['comment (cond
                    [else (values #f 'comment)])]
        ['o_sp (cond
                    [(char-numeric? character) (values #f 'int)]
                    [(sign? character) (values #f 'n_sign)]
                    [(space? character) (values #f 'o_sp)]
                    [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
                    [(par_open? character) (values #f 'par_open)]
                    [(par_close? character) (values #f 'par_close)]
                    [else (values #f 'fail)])]
        ['n_sp (cond
                    [(operator? character) (values #f 'op)]
                    [(division? character) (values #f 'div)]
                    [(space? character) (values #f 'n_sp)]
                    [(par_open? character) (values #f 'par_open)]
                    [(par_close? character) (values #f 'par_close)]
                    [else (values #f 'fail)])]
        ['fail (values #f 'fail)]
    )
)

