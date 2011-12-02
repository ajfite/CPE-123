;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |lab 16|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require (planet "main.rkt" ("clements" "rsound.plt" 2 9)))
(require (planet "draw.rkt" ("clements" "rsound.plt" 2 9)))

; Part 1

; a pom (piece of music) is 
; - (make-pn number number)
; - (make-seq pom pom)
; - (make-ovl pom pom)
(define-struct pn (nn dur))
(define-struct seq (pa pb))
(define-struct ovl (pa pb))
; Examples:
(make-pn 44 88000)
(make-seq (make-seq (make-pn 55 45) 
                    (make-pn 45 34)) 
          (make-pn 55 55))
(make-ovl (make-pn 34 7899)
          (make-seq (make-ovl (make-pn 55 6600)
                              (make-pn 65 6600))
                    (make-pn 55 44100)))

; Tester poms
(define pom1 (make-pn 44 88000))
(define pom2 (make-seq (make-seq (make-pn 55 45) 
                                 (make-pn 45 34)) 
                       (make-pn 25 55)))
(define pom3 (make-ovl (make-pn 34 7899)
                       (make-seq (make-ovl (make-pn 55 6600)
                                           (make-pn 65 6600))
                                 (make-pn 55 44100))))

; Part 2
; highest : pom pom -> number
; Takes in 2 poms and outputs the highest note
(define (highest pom)
  (cond [(pn? pom) (pn-nn pom)]
        [(seq? pom) (max (highest (seq-pa pom))
                         (highest (seq-pb pom)))]
        [(ovl? pom) (max (highest (ovl-pa pom))
                         (highest (ovl-pb pom)))]))

(check-expect (highest pom1) 44)
(check-expect (highest pom2) 55)
(check-expect (highest pom3) 65)

; Part 3
; longest : pom -> number
; Takes in a pom and outputs the longest 
(define (longest pom)
  (cond [(pn? pom) (pn-dur pom)]
        [(seq? pom) (max (longest (seq-pa pom)) 
                         (longest (seq-pb pom)))]
        [(ovl? pom) (max (longest (ovl-pa pom))
                         (longest (ovl-pb pom)))]))

(check-expect (longest pom1) 88000)
(check-expect (longest pom2) 55)
(check-expect (longest pom3) 44100)

; Part 4
; make-tone-midi : number number number -> rsound
; make tone but it uses a midi note number
(define (make-tone-midi note volume duration)
  (make-tone (midi-note-num->pitch note) volume duration))

; serialize : pom -> rsound
; takes in a pom and spits out the corresponding Rsound
(define (serialize pom)
  (cond [(pn? pom) (make-tone-midi (pn-nn pom) 1 (pn-dur pom))]
        [(seq? pom) (rs-append* (list (serialize (seq-pa pom))
                                      (serialize (seq-pb pom))))]
        [(ovl? pom) (overlay (serialize (ovl-pa pom))
                             (serialize (ovl-pb pom)))]))

(check-expect (rsound-equal? (serialize pom1)
                             (make-tone-midi 44 1 88000)) 
              true)
(check-expect (rsound-equal? (serialize pom2)
                             (rs-append* 
                              (list (make-tone-midi 55 1 45)
                                    (make-tone-midi 45 1 34)
                                    (make-tone-midi 25 1 55))))
              true)
(check-expect (rsound-equal? (serialize pom3)
                             (overlay
                              (make-tone-midi 34 1 7899)
                              (rs-append* 
                               (list (overlay (make-tone-midi 55 1 6600)
                                              (make-tone-midi 65 1 6600))
                                     (make-tone-midi 55 1 44100)))))
              true)