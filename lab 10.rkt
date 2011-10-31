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
(define (reverse-odd-seconds sound)
  (local [;current second = (floor (/ (rsound-frames sound) num))
          (define (odd-seconds num) (cond [(> (modulo num 88200) 44100) (rs-ith/left sound num)]
                                          [else (rs-ith/left sound (- (+ 44100 (- (* 44100  (floor (/ num 44100))) (modulo num 44100))) 1))]))]
    (mono-signal->rsound (rsound-frames sound) odd-seconds)
  )
)
(rsound-draw (reverse-odd-seconds (rs-read/clip "test.wav" 0 (* 44100 10))))
(play (reverse-odd-seconds (rs-read/clip "test.wav" 0 (* 44100 10))))
