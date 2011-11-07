#lang racket

(require (planet clements/rsound)
         racket/runtime-path
         rackunit)

(require "bass-sounds.rkt")

;; locate the pattern file
(define-runtime-path src-file "bach.txt")

;; define some constants
(define tempo 120)
(define secondsperbeat (/ 60 tempo))
(define framesperbeat (* (default-sample-rate) 
                         secondsperbeat))
(define linesperbeat 2)
(define framesperline (/ framesperbeat linesperbeat))

;; a trigger is (list number character number)
;; representing the column at which the sound
;; starts, the character representing the sound, 
;; and the number of columns (inclusive)
;; until the next entry.

;; convert a file to a list of list of triggers
(define (file->trigger-rows file)
  (map line->triggers (file->lines file)))

;; convert a string to a list of triggers and spaces
(define (line->triggers str)
  (define in-stream (open-input-string (string-append "." str)))
  (let loop ([posn 0])
    (match (regexp-match #px"^.[ ]*" in-stream)
      [#f empty]
      [other (define match-str (bytes->string/utf-8 (first other)))
             (cons (list 
                    posn
                    (string-ref match-str 0)
                    (string-length match-str))
                   (loop (+ posn (string-length match-str))))])))

(check-equal? (line->triggers "  34  7 ")
              (list (list 0 #\. 3) (list 3 #\3 1) (list 4 #\4 3) 
                    (list 7 #\7 2)))

;; convert a list of trigger-pairs to a list of 
;; sound/offset lists, for use with assemble
(define (triggers->overlay-list line triggers)
  (define line-octave-offset (+ 40 (* 12 (- 3 line))))
  (for/list ([t (in-list triggers)])
    (match t
      [(list start char dur)
       (define frames (* dur framesperline))
       (match char
         [#\. (list (silence 1) 0)]
         [other (list (synth-note (your-mapper
                                   (+ line-octave-offset
                                      (digit->half-steps other)))
                                  frames)
                      (* start framesperline))])])))

;; convert a scale-note-number to a number of half-steps
;; number -> number
(define (digit->half-steps digit)
  (match digit
    [#\1 0]
    [#\2 2]
    [#\3 4]
    [#\4 5]
    [#\5 7]
    [#\6 9]
    [#\7 11]
    [#\8 12]
    [#\9 14]))

;; read the file and play the resulting sound
(define (go)
  (define rows (file->trigger-rows src-file))
  ;; take only enough rows to match the sounds given
  #;(define num-taken (length trigger-rows))
  #;(define used-bool-rows (take bool-rows num-taken))
  #;(define used-sounds (take sounds num-taken))
  (define sound/offsets (for/list ([l (in-list rows)]
                                   [i (in-naturals)])
                          (triggers->overlay-list i l)))
  (define s (assemble (apply append sound/offsets)))
  (play s))


;; initially, "your-mapper" takes 'n' and returns 'n'.
(define (your-mapper n)
  n)