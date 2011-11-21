;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |echo filter notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
#lang racket

(require (planet clements/rsound))

(define snd
  (scale 0.5 (rs-read/clip "If I had $1000000.wav" 0 (* 30 44100))))

(define echoed
  (assemble (list (list snd 0)
                  (list (scale 0.5 snd) 44100))))

(play echoed)