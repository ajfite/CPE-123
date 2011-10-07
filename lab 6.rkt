#lang Racket
;Exercise 20
(define (string-join string1 string2) (string-append string1 "_" string2))
;Exercise 21
(define (string-insert string i) (string-append (substring string 0 i) "_" (substring string i (string-length string))))

;Lab 6
(require (planet "main.rkt" ("clements" "rsound.plt" 2 5)))
;Stutter
(define (stutter sound)
  (play (rs-append* (list (rs-read/clip sound 0 (round (/ (rsound-frames (rs-read sound)) 8)))
                          (rs-read/clip sound 0 (round (/ (rsound-frames (rs-read sound)) 8)))
                          (rs-read/clip sound 0 (round (/ (rsound-frames (rs-read sound)) 8)))
                          (rs-read/clip sound 0 (round (/ (rsound-frames (rs-read sound)) 8)))
                          (rs-read/clip sound 0 (round (/ (rsound-frames (rs-read sound)) 8)))
                          (rs-read/clip sound 0 (round (/ (rsound-frames (rs-read sound)) 8)))
                          (rs-read/clip sound 0 (round (/ (rsound-frames (rs-read sound)) 8)))
                          (rs-read/clip sound 0 (round (/ (rsound-frames (rs-read sound)) 8))))))
)
;Chord
(define (chord pitch1 pitch2 pitch3)
  (play (overlay* (list (make-tone pitch1 1 44100)
                        (make-tone pitch2 1 44100)
                        (make-tone pitch3 1 44100))))
)
;Classify
(define (classify pitch1 pitch2)
  (if (or (= (/ 2 3) (/ pitch1 pitch2)) (= (/ 3 2) (/ pitch1 pitch2))) "fifth" 
      (if (or (= (/ 5 4) (/ pitch1 pitch2)) (= (/ 4 5) (/ pitch1 pitch2))) "third" 
          (if (or (= (/ 6 5) (/ pitch1 pitch2)) (= (/ 5 6) (/ pitch1 pitch2))) "third"
              "NOPE Chuck Testa"))) 
)