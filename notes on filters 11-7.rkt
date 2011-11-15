#lang racket

(require (planet clements/rsound)
         (only-in (planet clements/rsound/util) iir-filter))

(define c (rs-read/clip "If I had $1000000.wav" 0 (* 10 44100)))
           
(play (iir-filter c (list (list 0 1.0))
                  (list (list 44100 .8))))