#lang racket

(require (planet "main.rkt" ("clements" "rsound.plt" 2 7)))
(require (planet "draw.rkt" ("clements" "rsound.plt" 2 7)))

;; Reverse a sound
(define (reverse-sound sound)
  (local [(define (sound-to-reverse num) (rs-ith/left sound (- (rsound-frames sound) (+ num 1))))]
    (mono-signal->rsound (rsound-frames sound) sound-to-reverse)
  )
)
;Does this count as a test case?
(rsound-draw (reverse-sound ding))

;;
#;(define reverse-odd-seconds
  ([local
    
  ])
)