;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |lab 8|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;Lab 8
(require (planet "main.rkt" ("clements" "rsound.plt" 2 5)))
(require (planet "draw.rkt" ("clements" "rsound.plt" 2 5)))


;function t, that accepts an integer n and returns the cosine of 2π*400*n/44100.
(define (t n) 
  (cos (/ (* 2 pi 400 n) 44100)))
(check-within (t 20) .4 .1)

;Generate sound using the above function
(play (mono-signal->rsound  44100 t))

;Draw the sound produced by the above
(rsound-draw (mono-signal->rsound  44100 t))

;Define sum-t to be sum of 3 waves
(define (sum-t n)
  (+ (sin (/ (* 2 pi 400 n) 44100)) (sin (* n (/ 15 pi))) (sin (/ n pi))))
;NEVER PLAY THIS WAVE. EVER. ಠ_ಠ
; Always run this commented out
(play (mono-signal->rsound  44100 sum-t)) 
(rsound-draw (mono-signal->rsound  44100 sum-t))

;Make play and draw the sound sample
(define soundclip (rs-read/clip "If i had $1000000.wav" 44100 44500))

(play (times 100 soundclip))
(rsound-draw soundclip)

;Attempting to replicate the audio clip with math for extra credit 
; ಠ_ಠ
; There is no way that is happening
