#lang racket

(require (planet clements/rsound)
         racket/runtime-path
         rackunit)
;Adding my sound
(define clip1 (rs-read "clip1.wav"))
(define clip2 (rs-read "clip2.wav"))
(define clip3 (rs-read "clip3.wav"))

;; locate the pattern file
(define-runtime-path src-file "percussion.txt")

;; define some constants
(define tempo 150)
(define secondsperbeat (/ 60 tempo))
(define framesperbeat (* (default-sample-rate) 
                         secondsperbeat))
(define colsperbeat 4)
(define framespercol (/ framesperbeat colsperbeat))

;; here's the list of sounds to be used.
(define raw-sounds (list clip1
                         clip2
                         clip3
                         crash-cymbal))

;; make the sounds quieter, so they won't cause clipping
(define sounds (map (lambda (s) (scale 0.2 s)) raw-sounds))

;; convert a file to a list of list of booleans
(define (file->bool-rows file)
  (map line->bools (file->lines file)))

;; convert a string to a list of booleans,
;; where every non-space character produces true
(define (line->bools str)
  (for/list ([ch (in-list (string->list str))])
    (not (equal? ch #\space))))

;; convert a list of booleans to a list of 
;; sound/offset lists, for use with assemble
(define (bools->overlay-list bools sound)
  (for/list ([b (in-list bools)]
             [t (in-naturals)]
             #:when b)
    (list sound (* t framespercol))))

;; read the file and play the resulting sound
(define (go)
  (define bool-rows (file->bool-rows src-file))
  ;; take only enough rows to match the sounds given
  (define num-taken (min (length bool-rows)
                         (length sounds)))
  (define used-bool-rows (take bool-rows num-taken))
  (define used-sounds (take sounds num-taken))
  (define sound/offsets (map
                         bools->overlay-list
                         used-bool-rows
                         used-sounds))
  (define s (assemble (apply append sound/offsets)))
  (play s)
  (rs-write s "Lab5Music.wav"))


;; a test case for line->bools
(check-equal? (line->bools "x x ") 
              (list #t #f #t #f))

;; a test case for bools->overlay-list
(check-equal? (bools->overlay-list (list false true false true)
                                   kick)
              (list (list kick (* 1 framespercol))
                    (list kick (* 3 framespercol))))

