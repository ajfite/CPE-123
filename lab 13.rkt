#lang racket
(require (planet clements/rsound)
         (planet clements/rsound/draw)
         rackunit)

;; USE THESE SOUNDS!
(define clip1 (rs-read "clip1.wav"))
(define sounds (list clip1 clip1)) 

;; sum-of durations : list of rsounds -> rsound
;; Takes in a list of sounds and outputs all their durations added
;; together in frames.
(define (sum-of-durations sounds) 
  (for/fold ([num 0])
    ([i (in-list sounds)])
    (+ num (rsound-frames i))))
; Testing 1 2 3
(sum-of-durations sounds)
(check-= (sum-of-durations sounds) 
         (* 2 (rsound-frames clip1))
         0)

;; sum : list of numbers -> number
;; Takes in a list of numbers and outputs their collective sum.
(define (sum list)
  (for/fold ([ num 0])
    ([i (in-list list)])
    (+ num i)))
; Testing 1 2 3
(sum (list 5 4 5))
(check-= (sum (list 5 4 5)) 
         (+ 5 4 5)
         0)

;; durations : list of rsounds -> list of numbers
;; Takes in a list of sounds and outputs a list of their durations
(define (durations sounds)
  (for/list ([i (in-list sounds)])
    (rsound-frames i)))
; Testing 1 2 3
; Clip1.wav duration = 10199
(durations sounds)

;; sum-of-durations-2 : list of rsounds -> number
;; Takes in a list of sounds and outputs all their durations added
;; together in frames.
(define (sum-of-durations-2 sounds) 
  (sum (durations sounds)))
; Testing 1 2 3
(sum-of-durations-2 sounds)
(check-= (sum-of-durations-2 sounds)
         (* 2 (rsound-frames clip1))
         0)

;; maybe-tone : number -> rsound
;; Takes in a midi number and outputs a tone for 1/4 of a second if 
;; the midi number is between 60 and 70.
(define (maybe-tone midi-note)
  (cond [(<= 60 midi-note 70) 
         (make-tone (midi-note-num->pitch midi-note) 1 (* 1/4 44100))]
        [else false]))
; Testing 1 2 3
(maybe-tone 65)

;; maybe-tones
;; Takes in a list of midi note numbers and returns a sound containing
;; Pitches returned by maybe-tone
(define (maybe-tones midi-list)
  (local [(define (check-note midi-list)
            (for/list ([i (in-list midi-list)])
              (maybe-tone i)))]
    (rs-append* 
     (for/list ([i (in-list (check-note midi-list))])
       (cond [(boolean? i) (silence 0)]
             [else i])))))
; Testing 1 2 3
(maybe-tones (list 5 6 65 67 56 67))
(play (maybe-tones (list 5 6 65 67 56 65 67)))