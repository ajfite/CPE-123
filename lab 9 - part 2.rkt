#lang Racket
(require (planet "main.rkt" ("clements" "rsound.plt" 2 5)))

; From "Lab 9.rkt"
(define (note n)
  (if (false? n)
      (silence 11025) (make-tone (* 440 (expt 2 (/ (- n 69) 12))) 1 22100))
)

; Make a song
;; list -> rsound : (notes->music notes) -> rsound
;; Takes in a list of midi notes, outputs an rsound

(define (notes->music notes)
   (rs-append* 
    (for/list ([notes (in-list notes)])
      (note notes))))

(play (notes->music (list 76 76 76 72 76 79 43 false 72 67 64 69 71 70 69 67 76 79 81 77 79 76 72 74 71 false 72 67 64 69 71 70 69 67 76 79 81 77 79 76 72 74 71)))

