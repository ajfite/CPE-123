;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname assignment1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require (planet "main.rkt" ("clements" "rsound.plt" 2 5)))

;Define song and silence
(define song "hg.wav")
(define silence1 (silence (- 58800 (- 29473 161)))) ;creates 2 seconds of silence

;cut song
(define clip1 (rs-read/clip song 22050 220500))
(define clip2 (rs-read/clip song 1054298 1274458))
(define clip3 (rs-read/clip song 2709704 2989256))

;make song
(define CompleteSong (rs-append* (list clip1 
                                       clip1
                                       clip1
                                       clip1
                                       silence1 
                                       clip2 
                                       clip3 )))
 
;play
(play CompleteSong)

;write
(rs-write CompleteSong "Assignment1Song.wav")




