#lang racket

(require (planet clements/rsound:2:8)
         "../includes/rsound_single-cycle_fixed.rkt"
         (planet clements/rsound/envelope)
         (planet clements/rsound/draw)
         racket/runtime-path
         rackunit)
         

;; locate the pattern file, use this to import txt files with the notes////////////////////////////////////////////////////////////
(define-runtime-path Piano "Tracker-test.txt") ; Change this to whatever text needed
;; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



;; define some constants of the song
(define tempo 120)
(define secondsperbeat (/ 60 tempo))
(define framesperbeat (* (default-sample-rate)
                         secondsperbeat))
(define linesperbeat 1)
(define framesperline (/ framesperbeat linesperbeat))
(define (your-mapper n)
  n)

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

(define (triggers->overlay-list line triggers family wave-num)
  (for/list ([t (in-list triggers)])
    (match t
      [(list start char dur)
       (note-mapper line start char dur family wave-num)])))

;; given the line of the note, the column in which it occurs,
;; the character that signals it, and the duration (in columns),
;; produce a list containing the sound and the placement, suitable
;; for use with assemble

(define (note-mapper line start char dur family wave-num)
  
  (define line-octave-offset (+ 36 (* 12 (- 3 (floor (/ line 7))))))
  (define frames (* dur framesperline))
  (match char
    [#\. (list (silence 1) 0)]
    [#\- (list (silence 1) 0)]
    [other (list (scale .5 (synth-note family wave-num(your-mapper
                                              (+ line-octave-offset(digit->half-steps other))) frames))
                                              (* start framesperline))]))

;; convert a scale-note-number to a number of half-steps
;; number -> number
(define (digit->half-steps digit)
  (match digit
    [#\C 0]
    [#\d 1]
    [#\D 2]
    [#\e 3]
    [#\E 4]
    [#\F 5]
    [#\g 6]
    [#\G 7]
    [#\a 8]
    [#\A 9]
    [#\b 10]
    [#\B 11]))

;;Sound is defined here
;///////////////////////////////////////////////////////////////////////////////////////////////////////
(define (Pianos file);;
  (define rows (file->trigger-rows file))
  (define sound/offsets (for/list ([l (in-list rows)]
                                   [i (in-naturals)])
                          (triggers->overlay-list i l "vgame" 1)));;Sound "Type" goes here and number
  (define s (assemble (apply append sound/offsets)))
 s)
;//////////////////////////////////////////////////////////////////////////////////////////////////////

;; Scalers
(define p .6)

;"Song" is here, Going to use a series of append's and overlays
(define Piano1 (scale p (Pianos Piano)))

;;Assemble song
(define Song Piano1)

;;Play and Write
(play Song)
(rs-write Song "Still Alive Team Gamma.wav")