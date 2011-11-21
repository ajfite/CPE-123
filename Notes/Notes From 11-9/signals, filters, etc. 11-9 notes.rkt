#lang racket

(require (planet clements/rsound))

(define msr mono-signal->rsound)

;; Tremolo
;; Something gets louder and softer and louder and softer
; makes a signal
(define (osc freq amp)
  (local [(define (sig f) 
            (sin (* 2 pi freq f 1/44100)))]
    sig))

; Adds 2 signals
(define (sig+ sig1 sig2)
  (local [(define (sig f)
            (+ (sig1 f) (sig2 f)))]
    sig))

; multiplies 2 signals
(define (sig* sig1 sig2)
  (local [(define (sig f)
            (* (sig1 f) (sig2 f)))]
    sig))
; Creates a wobble
(define (k amp)
  (local [(define (sig f) amp)]
    sig))

; Lets make a low frequency oscilator so it wavers
(define lfo-1 (sig+ (osc 3.2 1.0)
                    (k 0.8)))

(define (osc/f freq-sig amp)
  (local [(define (sig f) 
            (sin (* 2 pi (freq-sig f) f 1/44100)))]
    sig))


(play (msr (* 5 44100)
           (osc/f (sig+ (k 130)
                        (osc 80 50.0)) 0.2)))