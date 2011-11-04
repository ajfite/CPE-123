#lang racket

(require (planet clements/rsound)
         (planet clements/rsound/draw)
         rackunit)

(provide bass-eighths
         synth-note)

(define (straight-line frames a b)
  (local [(define (sig f) (+ a (* f (/ (- b a) frames))))]
  (mono-signal->rsound frames sig)))

(define (decay-line frames a b)
  (define a-log (log (max a 1e-2)))
  (define b-log (log (max b 1e-2)))
  (define (sig f) (exp (+ a-log (* f (/ (- b-log a-log) frames)))))
  (mono-signal->rsound frames sig))

(check-= (rs-ith/left (straight-line 30 0.2 0.3) 15) 0.25 1e-3)

;; if total is less than 
(define (adsr a ah d dh r)
  (local
    [(define (maker total)
       (rs-append* 
        (list
         (decay-line a 0 ah)
         (decay-line d ah dh)
         (decay-line (- total a d r) dh dh)
         (decay-line r dh 0))))]
    maker))

(define bass-adsr (adsr 200 1.0 2000 0.5 1000))

(define upper-bass-adsr (adsr 200 1.0 8000 0.1 100))

;; given a number of pitches, a lowest pitch, and a
;; number of frames per beat, produce a list of eighth 
;; notes.
(define (bass-eighths pitches lowest framesperbeat)
  (define dur (floor (/ framesperbeat 2)))
  (define lower-env (bass-adsr dur))
  (define upper-env (upper-bass-adsr dur))
  (reverse
   (for/list ([i (in-range pitches)])
     (define p (midi-note-num->pitch (+ lowest i)))
     (overlay
     (rs-mult upper-env (make-tone (* 2 p) 0.2 dur))
     (rs-mult lower-env (make-tone p 0.4 dur))))))


(define (synth-note note-num duration)
  (match (hash-ref note-hash (list note-num duration) #f)
    [#f (define lower-env (bass-adsr (floor duration)))
        (define upper-env (upper-bass-adsr (floor duration)))
        (define p (midi-note-num->pitch note-num))
        (define result
          (overlay
           (rs-mult upper-env (make-tone (* 2 p) 0.2 (floor duration)))
           (rs-mult lower-env (make-tone p 0.4 (floor duration)))))
        (hash-set! note-hash (list note-num duration) result)
        result]
    [other other]))

(define note-hash (make-hash))

;; test
#;(let ()
  (define be (bass-eighths 30 4 10))
  (check rsound-equal?
         (second be) 
         
         (make-tone (midi-note-num->pitch 32) 0.2 5)))