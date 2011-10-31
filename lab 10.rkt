#lang Racket

(require (planet "main.rkt" ("clements" "rsound.plt" 2 7)))
(require (planet "draw.rkt" ("clements" "rsound.plt" 2 7)))

(define test-music (rs-read/clip "If I had $1000000.wav" 0 (* 44100 15)))

;; reverse-sound : rsound -> rsound
;; Reverse a sound
(define (reverse-sound sound)
  (local [(define (sound-to-reverse num) (rs-ith/left sound (- (rsound-frames sound) (+ num 1))))]
    (mono-signal->rsound (rsound-frames sound) sound-to-reverse)
  )
)
;Testing 1 2 3
(rsound-draw ding)
(rsound-draw (reverse-sound ding))


;; reverse-odd-seconds : rsound -> rsound
;; Takes in a sound and reverses the odd seconds
(define (reverse-odd-seconds sound)
  (local [(define (odd-seconds num) (cond [(> (modulo num 88200) 44100) (rs-ith/left sound num)]
                                          [else (rs-ith/left sound (- (+ 44100 (- (* 44100  (floor (/ num 44100))) (modulo num 44100))) 1))]))]
    (mono-signal->rsound (rsound-frames sound) odd-seconds)
  )
)
; Testing 1 2 3
(rsound-draw (reverse-odd-seconds test-music))
;(play (reverse-odd-seconds test-music))


;; rescale : rsound -> rsound
;; takes in a sound and a number and returns a sound which is shrunk by the number
(define (rescale sound renum)
  (local [(define (make-a-sound num) (rs-ith/left sound (inexact->exact (/ num renum))))]
  (mono-signal->rsound (* (rsound-frames sound) renum) make-a-sound))
)
; Testing 1 2 3
(rsound-draw (rescale test-music .5))
(rsound-draw (rescale test-music 2))
(play (rescale test-music .5))


;; The random number explosion of sound and terror
