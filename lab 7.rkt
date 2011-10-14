;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |lab 7|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;Lab 7
(require (planet "main.rkt" ("clements" "rsound.plt" 2 5)))

;Midi note numbers from:
;http://tomscarff.110mb.com/midi_analyser/midi_note_numbers_for_octaves.htm

;All functions use "#" as the sharp sign rather than the harder to type "♯"
;Flat Sign is "♭" which is on no keyboard anywhere ever


;Up a major 3rd
(define (up-maj-3 freq) (* freq (/ 5 4)))
(check-expect (up-maj-3 256) 320)

;Midhid note number major 3rd
(define (up-maj-3/nn midi) (+ midi 4))
(check-expect (up-maj-3/nn 5) 9)

;Midi note number octave
(define (note-num->octave midinum)
  (- (floor (/ midinum 12)) 1)
)
(check-expect (note-num->octave 10) -1)
(check-expect (note-num->octave 13) 0)
(check-expect (note-num->octave 36) 2)

;accepts a MIDI note number and returns a name of the note
(define (note-num->class midinum)
  (cond [(= (modulo midinum 12) 0) "C"]
        [(= (modulo midinum 12) 1) "C#"]
        [(= (modulo midinum 12) 2) "D"]
        [(= (modulo midinum 12) 3) "D#"]
        [(= (modulo midinum 12) 4) "E"]
        [(= (modulo midinum 12) 5) "F"]
        [(= (modulo midinum 12) 6) "F#"]
        [(= (modulo midinum 12) 7) "G"]
        [(= (modulo midinum 12) 8) "G#"]
        [(= (modulo midinum 12) 9) "A"]
        [(= (modulo midinum 12) 10) "A#"]
        [(= (modulo midinum 12) 11) "B"]
        [else(error "Out of Range")]
  )
)
(check-expect (note-num->class 47) "B")

;Name of note to midi number
(define (name->note-num name octave)
  (+ (cond [(string=? name "C") 0]
           [(or (string=? name "C#") (string=? name "d♭")) 1]
           [(string=? name "D") 2]
           [(or (string=? name "D#") (string=? name "E♭")) 3]
           [(string=? name "E") 4]
           [(string=? name "F") 5]
           [(or (string=? name "F#") (string=? name "G♭")) 6]
           [(string=? name "G") 7]
           [(or (string=? name "G#") (string=? name "A♭")) 8]
           [(string=? name "A") 9]
           [(or (string=? name "A#") (string=? name "B♭")) 10]
           [(string=? name "B") 11]
           [else (error "Wrong Note Input")])
      (+ (* octave 12) 12))
)
(check-expect (name->note-num "C#" 1) 25) 
(check-expect (name->note-num "B♭" 5) 82)
(check-expect (name->note-num "G" 2) 43)
(check-expect (name->note-num "G" -1) 7)

;name to rsound
(define (name->rsound name octave)
  ;Equation from: 
  ;http://tomscarff.110mb.com/midi_analyser/midi_note_frequency.htm
  (make-tone (* 440 (expt 2 (/ (- (name->note-num name octave) 69) 12))) 1 22100)
)
;;Old checks for equation prior to addition of (make-tone) - Passed
;Check within because numbers are not exact
;(check-within (name->rsound "C" 4) 261.6 .1)
;(check-within (name->rsound "C" -1) 8.1 .1)

;Fun with scales
(play (rs-append* (list (name->rsound "C" 4)
                        (name->rsound "D" 4)
                        (name->rsound "E" 4)
                        (name->rsound "F" 4)
                        (name->rsound "G" 4)
                        (name->rsound "A" 4)
                        (name->rsound "B" 4)
                        (name->rsound "C" 5))))
