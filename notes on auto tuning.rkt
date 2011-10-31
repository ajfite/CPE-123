#lang racket

(require (planet clements/rsound)
         (planet clements/rsound/draw)
         rackunit)

(define hd (rs-read/clip "if I had $1000000.wav" 0 (* 15 44100)))


;lets try cutting chunks
(define chunk-len 5000)
;When chunk length is 2 its exactly the same as the next function which
;skips every other frame
#;(define out
  (rs-append*
    (for/list ([i (in-range
                   (floor (/ (rsound-frames hd) chunk-len)))])
      (clip hd
            (* i chunk-len)
            (+ (* i chunk-len) (/ chunk-len 2))))))


;Lets raise the pitch by doubling the frequency
#;(play
 (rs-append*
  (for/list ([i (in-range (floor (/ (rsound-frames hd) 2)))])
    (clip hd (* i 2) (+ 1 (* i 2))))))

;(play out)

;(rsound-draw (clip out 202500 205100))

;; window : interger -> number
;; computes the window function
(define (window f)
  (cond [(<= 0 f 1000)    (* 1/1000 f)]
        [(<= 1000 f 5000) 1]
        [else             (+ (* -1/1000 f) 6)]))

(check-= (window 0) 0.0 1e-4)
(check-= (window 1000) 1.0 1e-4)
(check-= (window 5000) 1.0 1e-4)
(check-= (window 5500) 0.5 1e-4)
(check-= (window 6000) 0.0 1e-4)

(define (window-mult snd f)
  (* (rs-ith/left snd f)
     (window f)))

(define my-clip (clip hd 202500 207500))

(define windowed-clip
  (local
    [(define (qrs f)
       (window-mult my-clip f))]
    (mono-signal->rsound
     5000
     qrs
     )))

(rsound-draw my-clip)
(rsound-draw windowed-clip)