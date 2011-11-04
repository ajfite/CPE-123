;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |lab 11|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require (planet "main.rkt" ("clements" "rsound.plt" 2 8)))
(require (planet "draw.rkt" ("clements" "rsound.plt" 2 8)))

; Part 1 Make the various tones into 1 rsound
(define tones (rs-append* (list (make-tone 400 1 44100)
                                (make-tone 450 1 44100)
                                (make-tone 500 1 44100)
                                (make-tone 550 1 44100))))

; Part 2 delay by n
(define (delay-by-n sound n) 
  (assemble (list (list sound 0)
                  (list sound n))))

(rsound-draw tones)

; Part 3 kill the 2nd and fourth tone
(define delay (/ 44100 100))
;(play (delay-by-n tones delay))
(rsound-draw (delay-by-n tones delay))

; Part 4 kill only the second tone
(define delay2 (/ 44100 900))
;(play (delay-by-n tones delay2))
(rsound-draw (delay-by-n tones delay2))


; Part 5 Kill all the notes or say it's impossible
;Killing all the notes is impossible because there is no offset
;you can find that will cancel all four simultaneously.