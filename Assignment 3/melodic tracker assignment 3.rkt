;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |melodic tracker assignment 3|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
#lang racket

(require (planet clements/rsound:2:8)
         (planet clements/rsound:2:8/single-cycle)
         (planet clements/rsound/envelope)
         (planet clements/rsound/draw)
         racket/runtime-path
         rackunit)
         

;; locate the pattern file, use this to import txt files with the notes////////////////////////////////////////////////////////////
(define-runtime-path Piano "VocalChorus.txt"); Change this to whatever text needed
;; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



;; define some constants of the song
(define tempo 120)
(define secondsperbeat (/ 60 tempo))
(define framesperbeat (* (default-sample-rate)
                         secondsperbeat))
(define linesperbeat 2)
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
  
  (define line-octave-offset (+ 40 (* 12 (- 3 (floor (/ line 7))))))
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
    [#\1 0]
    [#\! 1]
    [#\2 2]
    [#\@ 3]
    [#\3 4]
    [#\4 5]
    [#\$ 6]
    [#\5 7]
    [#\% 8]
    [#\6 9]
    [#\^ 10]
    [#\7 11]
    [#\8 12]
    [#\* 13]
    [#\9 14]))

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