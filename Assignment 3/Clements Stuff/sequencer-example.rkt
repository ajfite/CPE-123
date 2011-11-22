#lang racket

(require (planet clements/rsound)
         (planet clements/rsound/sequencer))

(define tone (make-tone 330 0.2 30000))
(define tone2 (make-tone 440 0.2 15000))

(define unplayed-heap (make-unplayed-heap))
(queue-for-playing! unplayed-heap tone 0)
(queue-for-playing! unplayed-heap tone 44100)
(for ([i (in-range 50)])
  (queue-for-playing! unplayed-heap tone2 (+ 1000 (* i 22050))))

(define-values (signal/block/unsafe last-time)
  (heap->signal/block/unsafe unplayed-heap))

(signal/block-play/unsafe signal/block/unsafe 44100)
