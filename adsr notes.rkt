#lang racket

(require rackunit)
(require (planet "main.rkt" ("clements" "rsound.plt" 2 7)))
(require (planet "draw.rkt" ("clements" "rsound.plt" 2 7)))

;Redefine mono-signal->rsound
(define msr mono-signal->rsound)

;; adsr :
;; given parameters, produce an adsr envelope
(define (adsr at dt rt ah sh frames)
  (local [(define st (- frames at dt rt))]
    (rs-append*
     (list
      (msr at (straight-line at 0 ah))
      (msr dt (straight-line dt ah sh))
      (msr st (straight-line st sh sh))
      (msr rt (straight-line rt sh 0))))))

;;straight-line : number number number -> (number -> number)
(define (straight-line dur a b)
  (local 
    [(define (sig f)
       (+ (* (/ (- b a) dur) f) a))]
    sig))

(check-= ((straight-line 500 0.8 1.0) 250)
         0.9
         0.000001)
(rsound-draw (adsr 1000 22 300 1.0 0.7 10000))
(play (rs-append* (list
       (make-tone 400 0.2 44100)
       (silence 44100)
       (rs-mult
        (make-tone 400 0.2 44100)
        (adsr 1000 22 300 1.0 0.7 10000)))))