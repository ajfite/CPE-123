;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |notes from 11-18 more structures, mixed data|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
#|
11/18/2011

Compound Data
- Functions for ^
Mixed Data
|#

; a bicycle is (make-bicycle number number string)
(define-struct bicycle (front-gears rear-gears brand))

#|
Functions created
make-bicycle
bicycle-front-gears
bicycle-rear-gears
bicycle-brand
bicycle? -> boolean
|#

; num-gears : bicycle -> number
; Computes the total number of gears.
(define (num-gears b)
  (* (bicycle-front-gears b) (bicycle-rear-gears b)))
(check-expect (num-gears (make-bicycle 3 5 "Schwinn")) 15)

;----------------------------------------------------------------

;a point is (make-point number number)
(define-struct point (x y))

; dist-from-zero : point -> number
(define (dist-from-zero p)
  (sqrt (+ (* (point-x p) (point-x p))
           (* (point-y p) (point-y p)))))
(check-within (dist-from-zero (make-point 1.0 2.0)) (sqrt 5.0) 1e-6)

#|----------------------------------------------------------------
Mixed data = OR :D
|#

; a zoo animal is either
;- (make-frog string number)
;- (make-flamingo number)
;- (make-lion number string)
(define-struct frog (species mass))
(define-struct flamingo (height))
(define-struct lion (people-eaten gender))

; good-for-petting : zoo-animal -> boolean
; should an animal be allowed in a petting zoo?
(define (good-for-petting z)
  (cond [(frog? z) (< (frog-mass z) 1500000)]
        [(lion? z) (= (lion-people-eaten z) 0)]
        [(flamingo? z) true]))
(check-expect (good-for-petting (make-frog "tree" 200)) true)
(check-expect (good-for-petting (make-frog "tree" 5000000)) false)
(check-expect (good-for-petting (make-lion 19 "female")) false)
(check-expect (good-for-petting (make-lion 0 "male")) true)
(check-expect (good-for-petting (make-flamingo 100)) true)





