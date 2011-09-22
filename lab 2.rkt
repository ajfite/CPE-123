;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |lab 2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)

(+ 3 (- 147 13))

(cos (/ (* 3 pi) 2))

(string-length "AJ Fite")

(> (string-length "Jeffrey") (string-length "James"))

(place-image (star-polygon 30 40 3 "solid" "brown") 100 -150             (place-image
 (rhombus 80 150 "solid" "pink") 90 250
(place-image 
 (triangle 60 "solid" "purple") 90 150 
 (place-image 
 (overlay (circle 10 "solid" "black") (circle 30 "solid" "green")) 140 80
  (place-image 
   (overlay (circle 10 "solid" "black") (circle 30 "solid" "green")) 50 80
   (empty-scene 200 300 "cyan"))))))