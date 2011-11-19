#lang racket

; a chord-pair is (make-chord-pair number number number)
(define-struct chord-pair (midi-note1 midi-note2 duration))
(chord-pair 65 128 44100)
(chord-pair 67 54 22100)


; a chord is (make-chord list number)
(define-struct chord (midi-note-list duration))
(chord (list 65 66 67 68) 44100)
(chord (list 22 62 128 -12) 88200)


; a key-signature is 
; (key-signature string string string string string string string)
(define-struct key-signature (A B C D E F G))
(key-signature "flat" "natural" "sharp" "natural" "flat" "sharp" "sharp")
(key-signature "natural" "flat" "flat" "flat" "flat" "flat" "flat")

; a chord-sequence is (make-chord-sequence list number)
(define-struct chord-sequence (chord-list volume))
(chord-sequence (list (chord 12 13) (chord 16 34)) 1)
(chord-sequence (list (chord 2 1) (chord 4 9)) 1)