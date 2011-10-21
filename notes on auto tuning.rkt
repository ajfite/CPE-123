#lang racket

(require (planet clements/rsound))

(define hd (rs-read "hg.wav"))


;lets try cutting chunks
(define chunk-len 2)
;When chunk length is 2 its exactly the same as the next function which
;skips every other frame
(define out
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