#lang racket

#|
Compound - and - pi
Mixed - Or - Zeta
---------------
|#
;; Compound

; A foo is (make-foo number bar)
(define-struct foo (a b))

; a bar is (make-bar string string)
(define-struct bar (c d))

(make-foo 5 (make-bar "car" "cat"))
(make-foo 6 (make-bar "train" "house"))

;--------------------------------

;; Mixed

;a foo2 is either
; - (make-apple number bar) <- one shape
; - (make-horse bar bar) <- Two shapes
(define-struct apple (e f))
(define-struct horse (g h))

(make-apple 6 (make-bar "yummy" "tasty"))
(make-horse (make-bar "car" "ford") 
            (make-bar "apple" "bannana"))

;-------------------------------
;Infinite shapes!

; a list-of-numbers is either
; - empty, or
; - (cons number list-of-numbers)
empty
(cons 4 empty)
(cons 9 (cons 23 (cons 2497279 empty)))