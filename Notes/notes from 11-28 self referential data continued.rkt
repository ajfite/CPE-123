;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |notes from 11-28 self referential data continued|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; a list-of-numbers is either
; - empty
; - (cons number list-of-numbers)

;------------------------------------------

; a pom (piece of music) is 
; - (make-pn number number)
; - (make-seq pom pom)
; - (make-ovl pom pom)
(define-struct pn (nn dur))
(define-struct seq (pa pb))
(define-struct ovl (pa pb))
; Examples:
(make-pn 64 44100)
(make-seq (make-pn 65 2) (make-pn 1 3))
(make-ovl (make-seq (make-pn 62 44100) 
                    (make-pn 61 22050))
          (make-pn 40 44100))

#|
Functions you can make with these data definitions
(make-pn)
(pn-nn)
(pn-dur)
(pn?)
(make-seq)
(seq-pa)
(seq-pb)
(seq?)
(make-ovl)
(ovl-pa)
(ovl-pb)
(ovl?)


Lab Side note:
 THERE ARE AT LEAST 2 TYPOS IN THE LAB
|#

(define pom-a (make-pn 64 44100))
(define pom-b (make-seq (make-pn 65 2) (make-pn 1 3)))
(define pom-c (make-ovl (make-seq (make-pn 62 44100) 
                                  (make-pn 61 22050))
                        (make-pn 40 44100)))

; pom-duration : pom -> number
; computes the duration of a piece of music
(define (pom-duration p)
  (cond [(pn? p) #| (pn-nn p) We don't need it cross it out 
                    (its here because of the template) |#
                 (pn-dur p)]
        [(seq? p) (+ (pom-duration (seq-pa p))
                     (pom-duration (seq-pb p)))]
        [(ovl? p) (max (pom-duration (ovl-pa p))
                       (pom-duration (ovl-pb p)))]))

(check-expect (pom-duration pom-a) 44100)
(check-expect (pom-duration pom-b) 5)
(check-expect (pom-duration pom-c) 66150)

; How to write an Rsound check-expect
(check-expect 
 (rsound-equal? (silence 4)
                (silence 64))
 true)
