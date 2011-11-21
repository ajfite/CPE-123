;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |lab 15|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require (planet "main.rkt" ("clements" "rsound.plt" 2 9)))
(require (planet "draw.rkt" ("clements" "rsound.plt" 2 9)))
(require "includes/fors.rkt")
(require "includes/rsound_single-cycle_fixed.rkt")

;; Part 1
; a note is either
; - (make-note number number)
; - (make-silence number)
(define-struct Note (midi-number duration))
(define-struct Silence (duration))

(make-Note 54 44100)
(make-Silence 88200)
(make-Note 43 22100)

;; Part 2
; notes->sound : list -> rsound
; Returns all the notes playing simultaneously
(define (notes->sound midi-note-list)
  (overlay* (for/list ([i (in-list midi-note-list)])
              (synth-note "main" 20 (Note-midi-number i) (Note-duration i)))))
(check-expect (rsound-equal? (notes->sound (list (make-Note 60 44100) 
                                   (make-Note 61 44100) 
                                   (make-Note 62 44100)))
               (overlay* (list (synth-note "main" 20 60 44100)
                               (synth-note "main" 20 61 44100)
                               (synth-note "main" 20 62 44100))))
              true)


;; Part 3
; sounds-nice-with-60? : Note -> boolean
; Returns true if the midi note is within 1, 2, or 6 half-steps
(define (sounds-nice-with-60? midi-num)
  (cond [(Silence? midi-num) true]
        [(or (= 61 (Note-midi-number midi-num)) 
             (= 62 (Note-midi-number midi-num)) 
             (= 66 (Note-midi-number midi-num))
             (= 59 (Note-midi-number midi-num))
             (= 58 (Note-midi-number midi-num))
             (= 54 (Note-midi-number midi-num))) false]
        [else true]))

(check-expect (sounds-nice-with-60? (make-Note 58 44100)) false)
(check-expect (sounds-nice-with-60? (make-Note 70 44100)) true)
(check-expect (sounds-nice-with-60? (make-Silence 44100)) true)

;; Part 4
; sounds-nice/2? : Note Note -> boolean
; Returns true if either note is silence or not within 1, 2, or 6 half steps 
(define (sounds-nice/2? note1 note2)
  (local [(define note-1 
            (if (Note? note1) (Note-midi-number note1) note1))
          (define note-2 
            (if (Note? note2) (Note-midi-number note2) note2))]
  (cond [(or (Silence? note2)
             (Silence? note1)) true]
        [(or (= (- note-1 note-2) 1)
             (= (- note-1 note-2) -1)
             (= (- note-1 note-2) 2)
             (= (- note-1 note-2) -2)
             (= (- note-1 note-2) 6)
             (= (- note-1 note-2) -6)) false]
        [else true])))

(check-expect (sounds-nice/2? (make-Note 58 44100) (make-Note 60 44100)) false)
(check-expect (sounds-nice/2? (make-Note 57 44100) (make-Note 60 44100)) true)
(check-expect (sounds-nice/2? (make-Silence 44100) (make-Note 60 44100)) true)

;; Part 5
; sounds-nice/3? : Note Note Note -> boolean
; Returns true if any 2 notes are silence or not within 1, 2, or 6 half steps 
(define (sounds-nice/3? note1 note2 note3)
  (local [(define note-1 
            (if (Note? note1) (Note-midi-number note1) note1))
          (define note-2 
            (if (Note? note2) (Note-midi-number note2) note2))
          (define note-3
            (if (Note? note3) (Note-midi-number note3) note3))]
    (cond [(and (Note? note1)(Note? note2)) 
           (if (or (= (- note-1 note-2) 1)
                   (= (- note-1 note-2) -1)
                   (= (- note-1 note-2) 2)
                   (= (- note-1 note-2) -2)
                   (= (- note-1 note-2) 6)
                   (= (- note-1 note-2) -6)) false true)]
          [(and (Note? note2)(Note? note3)) 
           (if (or (= (- note-3 note-2) 1)
                   (= (- note-3 note-2) -1)
                   (= (- note-3 note-2) 2)
                   (= (- note-3 note-2) -2)
                   (= (- note-3 note-2) 6)
                   (= (- note-3 note-2) -6)) false true)]
          [(and (Note? note3)(Note? note1))
           (if (or (= (- note-1 note-3) 1)
                   (= (- note-1 note-3) -1)
                   (= (- note-1 note-3) 2)
                   (= (- note-1 note-3) -2)
                   (= (- note-1 note-3) 6)
                   (= (- note-1 note-3) -6)) false true)]
          [else true])))

(check-expect (sounds-nice/3? (make-Note 58 44100) (make-Note 60 44100) (make-Note 69 44100)) false)
(check-expect (sounds-nice/3? (make-Note 57 44100) (make-Note 60 44100) (make-Note 63 44100)) true)
(check-expect (sounds-nice/3? (make-Silence 44100) (make-Note 60 44100) (make-Note 72 44100)) true)
(check-expect (sounds-nice/3? (make-Silence 44100) (make-Note 60 44100) (make-Note 58 44100)) false)
(check-expect (sounds-nice/3? (make-Note 58 44100) (make-Silence 44100) (make-Note 60 44100)) false)

;; Part 6
;
;

;; Part 7
; a chord is (make-chord Note Note Note)
(define-struct chord (Note1 Note2 Note3))

(make-chord (make-Note 23 44100) 
            (make-Note 24 44100) 
            (make-Note 25 44100))

;; Part 8
;
;