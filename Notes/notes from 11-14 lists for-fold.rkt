#lang racket
;; List shorthand
'(3 4) ; = (list 3 4)

;; Sequences
; Lists - (list 3 4) (list 2) empty
; Arrays/Vectors - 

;; List
(cons 3 (cons 4 empty)) ; = (list 3 4)
(cons 3 (list 4)) ; = (list 3 4) 
(first (cons 3 (cons 4 empty))) ; = 3
(rest (cons 3 (cons 16 empty))) ; = (list 16) or (cons 16 empty)

#|-----------------------------------------------------------------
for/list : evaluate

                                            (in-range ...)
                             generator ->   (in-list ...)
(for/list ([variable_name generator])
         expr)

produce a list containing the result of evaluating the expression
for each element of the generator
|#

(for/list ([i (in-range 4)])   ; = (list 2 3 4 5)
  (+ i 2))

#|-----------------------------------------------------------------
for/fold

(for/fold  ([variable_name expr])  ;<-- Accumulator
           ([variable_name generator])
           expr)

for each element from the generator update the accumulator with
the new value
|#

(for/fold ([sum 0])              ; = 135
  ([n (in-list (list 7 134 -6))])
  (+ n sum))

(define SCUBA '("Self" "Contained" "Underwater" "Breathing" "Apparatus"))
(for/fold ([ack ""])
  ([word (in-list SCUBA)])
  (string-append ack (substring word 0 1)))