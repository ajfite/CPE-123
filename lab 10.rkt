;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |lab 10|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require (planet "main.rkt" ("clements" "rsound.plt" 2 7)))
(require (planet "draw.rkt" ("clements" "rsound.plt" 2 7)))


;; reverse-sound : rsound -> rsound
;; Reverse a sound
(define (reverse-sound sound)
  (local [(define (sound-to-reverse num) (rs-ith/left sound (- (rsound-frames sound) (+ num 1))))]
    (mono-signal->rsound (rsound-frames sound) sound-to-reverse)
  )
)
;Testing 1 2 3
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
(rsound-draw (reverse-odd-seconds (rs-read/clip "If I had $1000000.wav" 0 (* 44100 60))))
(play (reverse-odd-seconds (rs-read/clip "If I had $1000000.wav" 0 (* 44100 60))))


;; rescale : rsound -> rsound
;; takes in a sound and a number and returns a sound which is shrunk by the number
(define (rescale sound renum)
  (local [
         ])
) 