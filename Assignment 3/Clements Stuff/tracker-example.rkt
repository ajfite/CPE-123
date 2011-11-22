;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname tracker-example) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/universe)
(require 2htdp/image)

;; for now, a world is (make-world number number)
(define-struct world (col row))

;; draw the current state of the world:
(define (draw-world w)
  (place-image/align
   (rectangle cell-width cell-height 'outline 'purple)
   (* cell-width (world-col w))
   (* cell-height (world-row w)) "left" "top"
   (empty-scene window-width window-height)))

;; handle a key: given a world and a key-event, return the 
;; new state of the world.
(define (handle-key w ch)
  (cond 
    [(equal? ch "down") (make-world (world-col w) (min (sub1 rows)
                                                       (add1 (world-row w))))]
    [(equal? ch "up") (make-world (world-col w) (max 0 (sub1 (world-row w))))]
    
    [(equal? ch "right") (make-world (min (sub1 cols)
                                          (add1 (world-col w)))
                                     (world-row w))]
    [(equal? ch "left") (make-world (max 0 (sub1 (world-col w)))
                                     (world-row w))]
    [else w]))


;; graphical constants:
(define cell-width 100)
(define cell-height 30)
(define cols 3)
(define rows 20)
(define window-width (* cell-width cols))
(define window-height (* cell-height rows))

;; test by inspection:
;(draw-world (make-world 1 2))

;; test cases for handle-key:
(check-expect (handle-key (make-world 0 0) "up") (make-world 0 0))
(check-expect (handle-key (make-world 0 0) "down") (make-world 0 1))
(check-expect (handle-key (make-world 0 0) "left") (make-world 0 0))
(check-expect (handle-key (make-world 0 0) "right") (make-world 1 0))
(check-expect (handle-key (make-world 2 19) "up") (make-world 2 18))
(check-expect (handle-key (make-world 2 19) "down") (make-world 2 19))
(check-expect (handle-key (make-world 2 19) "left") (make-world 1 19))
(check-expect (handle-key (make-world 2 19) "right") (make-world 2 19))
(check-expect (handle-key (make-world 3 4) "p")  (make-world 3 4))

;; start the world:
(big-bang (make-world 0 0)
          [to-draw draw-world]
          [on-key handle-key])

