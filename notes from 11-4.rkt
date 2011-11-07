#lang racket

(require plot)

(define i (sqrt -1))

;; This doesn't work cause plot has a  massive update that is not out yet >_>
#;(define (f omega)
  (magnitude
   ;Note that "exp" is always e^n, "expt" is any-number^n
   (+ 1 (exp (* -1 i 2 pi omega 1/44100 0.64114136)))))

#;(plot
 (function f)
 #:x-min 0
 #:x-max 22050)

;;This does work :D
(define (m z)
  (+ 7/10 (* 33/20 (expt z 2)) (* 2/3 (expt z 4))))

(define (f x y)
  (magnitude (m (+ x (* i y)))))

(define (adapter omega)
  (magnitude (m (exp (* i 2 pi omega -1/44100)))))

(plot3d
 (surface f)
 #:x-min -1.0
 #:x-max 1.0
 #:y-min -1.0
 #:y-max 1.0)

;This doesn't :(
#;(plot
 (function adapter)
 #:x-min 0
 #:x-max 22050)