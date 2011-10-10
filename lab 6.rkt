#lang Racket
;Exercise 20
(define (string-join string1 string2) (string-append string1 "_" string2))
(string-join "this is" "a string")
;Exercise 21
(define (string-insert string i) (string-append (substring string 0 i) "_" (substring string i (string-length string))))
(string-insert "I put a  here" 8)  

;Lab 6
(require (planet "main.rkt" ("clements" "rsound.plt" 2 5)))
;Stutter
(define (stutter sound)
        (rs-append* (list (clip sound 0 (round (/ (rsound-frames sound) 8)))
                          (clip sound 0 (round (/ (rsound-frames sound) 8)))
                          (clip sound 0 (round (/ (rsound-frames sound) 8)))
                          (clip sound 0 (round (/ (rsound-frames sound) 8)))
                          (clip sound 0 (round (/ (rsound-frames sound) 8)))
                          (clip sound 0 (round (/ (rsound-frames sound) 8)))
                          (clip sound 0 (round (/ (rsound-frames sound) 8)))
                          (clip sound 0 (round (/ (rsound-frames sound) 8))))))
(play (stutter ding))
                        
;Chord
(define (chord pitch1 pitch2 pitch3)
   (overlay* (list (make-tone pitch1 1 44100)
                        (make-tone pitch2 1 44100)
                        (make-tone pitch3 1 44100)))
)
(play (chord 150 250 350))

;Classify
(define (classify pitch1 pitch2)
  (if (= (/ 2 3) (/ pitch1 pitch2)) "fifth"
      (if (= (/ 5 4) (/ pitch1 pitch2)) "third" 
          (if (= (/ 6 5) (/ pitch1 pitch2)) "third"
              "Unknown"))) 
)
(classify 2 3)

;Noisy
(define (noisy n)
  (/ (- (random 100 (make-pseudo-random-generator)) 50) 200)
)

;Squarewave -> Sound
(play (mono-signal->rsound 44100 noisy))
;WHAT AM I HEARING

;Modulo
(define (squarewave n)
  (if (< (modulo n 200) 100) 10000 0) 
)

;Mono signal again
(play (mono-signal->rsound 44100 squarewave))
;this one sounds better then the other one
