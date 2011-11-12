#lang racket

(require (planet clements/rsound:2:8)
         (planet clements/rsound:2:8/single-cycle)
         (planet clements/rsound/envelope)
         (planet clements/rsound/draw)
         racket/runtime-path
         rackunit)
         

;; locate the pattern file, use this to import txt files with the notes////////////////////////////////////////////////////////////
(define-runtime-path VocalChorus "VocalChorus.txt"); Change this to whatever text needed
(define-runtime-path Guitar3Chorus2 "Guitar3Chorus2.txt")
(define-runtime-path Guitar2Chorus2 "Guitar2Chorus2.txt")
(define-runtime-path VocalVerse1 "VocalVerse1.txt")
(define-runtime-path Guitar2Verse1 "Guitar2Verse1.txt")
(define-runtime-path Guitar2Chorus1 "Guitar2Chorus1.txt")
(define-runtime-path Guitar2Verse2 "Guitar2Verse2.txt")
(define-runtime-path Guitar3Interlude "Guitar3Interlude.txt")
(define-runtime-path VocalInterlude "VocalInterlude.txt")
(define-runtime-path Guitar2Verse3 "Guitar2Verse3.txt")
(define-runtime-path VocalVerse2 "VocalVerse2.txt")
(define-runtime-path VocalVerse3 "VocalVerse3.txt")
(define-runtime-path VocalOutro "VocalOutro.txt")
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
    [other (list (synth-note  family wave-num(your-mapper 
                                              (+ line-octave-offset(digit->half-steps other)))  frames) 
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
(define (vocal file);;
  (define rows (file->trigger-rows file))
  (define sound/offsets (for/list ([l (in-list rows)]
                                   [i (in-naturals)])
                          (triggers->overlay-list i l "path" "Voice.wav")));;Sound "Type" goes here and number
  (define s (assemble (apply append sound/offsets)))
 s)
(define (Guitar2 file);;
  (define rows (file->trigger-rows file))
  (define sound/offsets (for/list ([l (in-list rows)]
                                   [i (in-naturals)])
                          (triggers->overlay-list i l "path" "aguitar.wav")));;Sound "Type" goes here and number
  (define s (assemble (apply append sound/offsets)))
 s)
(define (Guitar3 file);;
  (define rows (file->trigger-rows file))
  (define sound/offsets (for/list ([l (in-list rows)]
                                   [i (in-naturals)])
                          (triggers->overlay-list i l "path" "eguitar.wav")));;Sound "Type" goes here and number
  (define s (assemble (apply append sound/offsets)))
 s)
;//////////////////////////////////////////////////////////////////////////////////////////////////////

;"Song" is here, Going to use a series of append's and overlays
(define Chorus2 (overlay* (list (scale .4 (vocal VocalChorus))
                                (scale .1 (Guitar2 Guitar2Chorus2))
                                (scale .1 (Guitar3 Guitar3Chorus2)))))
(define Chorus1 (overlay* (list (scale .4 (vocal VocalChorus))
                                (scale .1 (Guitar2 Guitar2Chorus1)))))
(define Verse1 (overlay* (list (scale .4 (vocal VocalVerse1))
                               (scale .1 (Guitar2 Guitar2Verse1)))))
(define Chorus3 (scale .5 (vocal VocalChorus)))
(define Verse2 (overlay* (list (scale .4 (vocal VocalVerse2))
                               (scale .1 (Guitar3 Guitar2Verse2)))))
(define Interlude (overlay* (list (scale .4 (vocal VocalInterlude))
                                  (scale .1 (Guitar3 Guitar3Interlude)))))
(define Verse3 (overlay* (list (scale .4 (vocal VocalVerse3))
                               (scale .1 (Guitar2 Guitar2Verse3)))))
(define Outro (scale .5 (vocal VocalOutro)))

(define Song (rs-append* (list Verse1
                               Chorus1
                               Verse2
                               Chorus2
                               Interlude
                               Verse3
                               Chorus3
                               Outro)))
(play Song)
(rs-write Song "Still Alive Team Gamma.wav")