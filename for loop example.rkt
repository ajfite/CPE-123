#lang racket

(define my-list (list "cat" "dog" "elephant"))

(for/list ([str (in-list my-list)])
  (string-length str))

(for/list ([str (in-list my-list)])
  (string-append "MY " str))

;; pitches->wavelens : (listof number) -> (listof number)
;; given a list of pitches, return a list of wavelengths in frames
(define (pitches->wavelens pitches)
  (for/list ([pitch (in-list pitches)])
    (* 44100 (/1 pitch))))

(pitches->wavelens (list 441 882))

#|

(check-equal? (pitches->wavelens (list 441 882))
              (list 100 50))

|#

; #; removes everything from the paranthesis it is at to the closing parentheis

#;(check-equal? (pitches->wavelens (list 441 882))
              (list 100 50))
