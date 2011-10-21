#lang Racket
(require (planet "main.rkt" ("clements" "rsound.plt" 2 5)))

; From "Lab 9.rkt"
(define (note n)
  (if (false? n)
      (silence 11025) (make-tone (* 440 (expt 2 (/ (- n 69) 12))) 1 22100))
)

; Make a song
;; 
;;

(define (notes->music notes)
   (rs-append* 
    (for/list ([notes (in-list notes)])
      (note notes))))

(play (notes->music (list 64 64 65 67 67 65 64 62 60 60 62 64 64 62 62 false 64 64 65 67 67 65 64 62 60 60 62 64 62 60 60)))

