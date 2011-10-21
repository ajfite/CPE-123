#lang Racket

; From "Lab 9.rkt"
(define (note n)
  (if (false? n)
      (silence 11025) (make-tone (* 440 (expt 2 (/ (- n 69) 12))) 1 22100))
)

; Make a song
;; 
;;
