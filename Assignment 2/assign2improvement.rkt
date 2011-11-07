#lang racket

(require (planet clements/rsound:2:8)
         (planet clements/rsound:2:8/single-cycle)
         #;"bass-sounds.rkt"
         racket/runtime-path
         rackunit)

;; locate the pattern file, use this to import txt files with the notes
(define-runtime-path src-file "bach2.txt" #;"dontgo.txt")
#;(define-runtime-path src-file2 "verse1.txt")
#;(define-runtime-path src-file3 "Chorus.txt")

;; define some constants
(define tempo 120)
(define secondsperbeat (/ 60 tempo))
(define framesperbeat (* (default-sample-rate) 
                         secondsperbeat))
(define linesperbeat 8)
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
(define (triggers->overlay-list line triggers family wave-num)
  (for/list ([t (in-list triggers)])
    (match t
      [(list start char dur)
       (note-mapper line start char dur family wave-num)])))

;; read the file and play the resulting sound
;; This takes a note and allows us to make sound


;;Repeat this for every sound we use, use the src-file for the the part and the envelope
;;This is the predefined sound, uses a library and a number that is already made.
(define (go family wave-num)
  (define rows (file->trigger-rows src-file))
  (define sound/offsets (for/list ([l (in-list rows)]
                                   [i (in-naturals)])
                          (triggers->overlay-list i l family wave-num)))
  (define s (assemble (apply append sound/offsets)))
  (play s))

;;This is a sound made from an envolope WE chose.
(define (Sound2)
  (define rows (file->trigger-rows src-file3))
  (define sound/offsets (for/list ([l (in-list rows)]
                                   [i (in-naturals)])
                          (triggers->overlay-list i l)))
  (define s (assemble (apply append sound/offsets)))
  (play s))
;;
#;(define FINAL SONG (append (overlay) bla bla bla))




;; given the line of the note, the column in which it occurs,
;; the character that signals it, and the duration (in columns),
;; produce a list containing the sound and the placement, suitable
;; for use with assemble
(define (note-mapper line start char dur family wave-num)
  
  (define line-octave-offset (cond 
                                   
                                   [(and (>= line 1) (<= line 5)) (+ 40 (* 12 (- 3 0)))]
                                   [(and (>= line 7) (<= line 11)) (+ 40 (* 12 (- 3 1)))]
                                   [(and (>= line 13) (<= line 17)) (+ 40 (* 12 (- 3 2)))]
                                   [(and (>= line 19) (<= line 23)) (+ 40 (* 12 (- 3 3)))]
                                   [(and (>= line 25) (<= line 29)) (+ 40 (* 12 (- 3 4)))]
                                   [(and (>= line 31) (<= line 35)) (+ 40 (* 12 (- 3 5)))]
                                   ))
  
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

;; initially, "your-mapper" takes 'n' and returns 'n'.
(define (your-mapper n)
  n)

(go "vgame" 5)