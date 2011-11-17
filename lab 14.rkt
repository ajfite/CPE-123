#lang racket

; a chord-pair is (make-chord-pair number number number)
(define-struct chord-pair (midi-note1 midi-note2 duration))
(chord-pair 65 128 44100)

; a chord is (make-chord list number)
(define-struct chord (midi-note-list duration))
(chord (list 65 66 67 68) 44100)

; a key-signature is 
;(key-signature string string string string string string string)
(define-struct key-signature (A B C D E F G))
(key-signature "flat" "natural" "sharp" "natural" "flat" "sharp" "sharp")

; a chord-sequence is (make-chord-sequence list number)
(define-struct chord-sequence (chord-list volume))
(chord-sequence (list (chord 12 13) (chord 16 34)) 1) 

