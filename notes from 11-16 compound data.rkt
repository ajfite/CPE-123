#lang racket

#| Compound Data
A value that contains other values
 - A car has many parts
 - A cartesian point has 2 numbers
------------------------------------
- Structures
- Object
- Structs
- Hash
|#

; a point is (make-point number number)     ; These 2 things are
(define-struct point (x y))                 ; called a data definition

(make-point 3.6 -14.2)
(make-point 167 3e-5)
(make-point (+ 3 4) (* 12 12))

; as demonstrated the shorthand also works in the full language
(point 10 11)

; a frog is (make-frog string string number)
(define-struct frog (species gender calorie-intake))

(make-frog "swamp" "male" 320)
(frog "tree" "female" 500)

; make-frog: string string number -> frog
; frog-species: frog -> string
; frog-gender: frog -> string
; frog-calorie-intake: frog -> number