;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |lab 9|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require (planet "main.rkt" ("clements" "rsound.plt" 2 5)))
(require (planet "draw.rkt" ("clements" "rsound.plt" 2 5)))

; Attenuation
;; frequency and time -> rsound : (ring f t) -> (rsound)
;; given frequency f and time t and produces a sine wave tone at that frequency which lasts for 4t seconds
(define (ring f t)
  ;The only reason this works is because my team is awesome.
  (local 
    [(define (wave rate)
       (* (/ 1 (expt 2 (/ rate (* t 44100)))) (sin (/ (* 2 pi f rate) 44100))))]
    (mono-signal->rsound (* 176400 t) wave)
  )
)
(rsound-draw (ring 500 5))

; Interference
;; frequency and beat-time -> rsound : (beat f t) -> rsound
;; given frequency and beat-time it produces a sound of duration 4t that contains 2 sine waves that beat
(define (beat f t)
  (local
    [(define (frequency1 x)
       (/ (sin (/ (* 2 pi f (/ 1 t) x) 44100)) 2))
     (define (frequency2 x) 
       (/ (sin (/ (* 2 pi (+ f 1) (/ 1 t) x) 44100)) 2))]
    (overlay (mono-signal->rsound (* 4 t 44100) frequency1)
             (mono-signal->rsound (* 4 t 44100) frequency2))
                                  
  )
)
(rsound-draw (beat 440 1))
(play (beat 440 1))

; Sequencing
;; Midi note number -> rsound : (note n) -> rsound
;; Given a midi note number produce a tone, given false produce silence
(define (note n)
  (if (false? n)
      (silence 11025) (make-tone (* 440 (expt 2 (/ (- n 69) 12))) 1 22100))
)

; Make a song
;; SEE "lab 9 - part 2.rkt"
