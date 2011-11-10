#lang racket
(require (planet "main.rkt" ("clements" "rsound.plt" 2 8)))
(require (planet "draw.rkt" ("clements" "rsound.plt" 2 8)))
(define i (sqrt -1))

; PART 1
;; http://www.wolframalpha.com/input/?i=1%2B.4*%28z^%28-2%29%29%2B.2*%28z^%28-5%29%29

; Real root at:
; z ≈ -0.630583            == .630583

; Complex roots at:
; z ≈ -0.176957-0.804697i  == .8239241722743664
; z ≈ -0.176957+0.804697i  == .8239241722743664
; z ≈ 0.492249-0.474239i   == .6835288634154376
; z ≈ 0.492249+0.474239i   == .6835288634154376

(define a -0.176957)
(define b 0.804697)
(sqrt (+ (expt a 2) (expt b 2)))

; -0.176957-0.804697i and -0.176957+0.804697i 
; are closest to the unit circle


; PART 2
; Kill off 4500hz and 7803hz
(define tones (rs-append* (list (make-tone 3500 .2 44100)
                                (make-tone 4500 .2 44100)
                                (make-tone 7503 .2 44100)
                                (make-tone 7803 .2 44100))))

; Computing necesarry numbers for filter
(exp (* 2 pi i 7803/44100))
(exp (* 2 pi i 4500/44100))
(exp (* 2 pi i -7803/44100))
(exp (* 2 pi i -4500/44100))

; Making Polynomial 
;;http://www.wolframalpha.com/input/?i=%28z+-+0.4431031224612913%2B0.896470648077813i%29%28z+-+0.8014136218679566%2B0.598110530491216i%29%28z+-+0.4431031224612913-0.896470648077813i%29%28z+-+0.8014136218679566-0.598110530491216i%29

(define filtered
  (assemble (list (list tones 4)
                  (list (scale -2.489033488658496 tones) 3)
                  (list (scale 3.42043551293082 tones) 2)
                  (list (scale -2.48903348865850 tones) 1)
                  (list tones 0))))
(rsound-draw filtered)
(play filtered)
