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
(define tones (rs-append* (list (make-tone 3500 1 44100)
                                (make-tone 4500 1 44100)
                                (make-tone 7503 1 44100)
                                (make-tone 7803 1 44100))))

; Computing necesarry numbers for filter

(define theta-4500 (* 2 pi (/ 4500 44100)))
(define a-4500 (* 4500 (cos theta-4500)))
(define i-4500 (* 4500 (sin theta-4500)))

(define theta-7803 (* 2 pi (/ 7803 44100)))
(define a-7803 (* 7803 (cos theta-7803)))
(define i-7803 (* 7803 (sin theta-7803)))

(define theta--4500 (* 2 pi (/ -4500 44100)))
(define a--4500 (* 4500 (cos theta--4500)))
(define i--4500 (* 4500 (sin theta--4500)))

(define theta--7803 (* 2 pi (/ -7803 44100)))
(define a--7803 (* 7803 (cos theta--7803)))
(define i--7803 (* 7803 (sin theta--7803)))
 
(+ a-4500 (* i-4500 i))
(+ a-7803 (* i-7803 i))
(+ a--4500 (* i--4500 i))
(+ a--7803 (* i--7803 i))

; Making Polynomial 
;; http://www.wolframalpha.com/input/?i=%28z-3606.361298405805%2B2691.497387210472i%29%28z-3457.533664565456%2B6995.160466951174i%29%28z-3606.361298405805-2691.497387210472i%29%28z-3457.533664565456-6995.160466951174i%29
; z^4 - (14127.78992594252+0.×10^-11 i)z^3 + (1.310132713832962×10^8+0.×10^-7 i)z^2 - (5.79189776536953×10^11+0.×10^-3 i)z + (1.232957882250000×10^15+0. i)
; Simplifying and removing extraneous rounding stuff
; z^4 - 14127.78992594252z^3 + 1.310132713832962z^2 - 5.79189776536953z + 1.232957882250000

(define filtered
  (assemble (list (list tones 0)
                  (list (scale 1 tones) (* 1125 4))
                  (list (scale -14127.78992594252 tones) (* 3 1125))
                  (list (scale 1.310132713832962 tones) (* 2 1125))
                  (list (scale -5.79189776536953 tones) (* 1 1125))
                  (list (scale 1.232957882250000 tones) 0))))
(rsound-draw filtered)
(play filtered)
