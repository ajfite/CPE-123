#lang scribble/doc

@(require scribble/manual)

@section{Solving requirements:}

For every problem below that asks you to develop a program, you should
be able to follow the steps of the design recipe, including:

a) purpose statement and contract and header,
b) test cases (for programs that don't produce rsounds),
c) the template for the given input data
d) finishing the program

Note that your functions must accept arguments in the order specified by
the problem.

It is always okay to develop helper functions.

All programs should be written in Racket.

Numeric, string and note constants are subject to change in the exam.  For
instance, the number 3 might be replaced by 4, or the string
"bar" by "Rowdy Roddy Piper", or the note C# by E flat, or the identifier
ruggle with buggle.


@section{Musical Ratios}

  @problem{What interval is defined by the ratio between the first & second harmonics?}
  @problem{What interval is defined by the ratio between the second & third harmonics?}
  @problem{What interval is defined by the ratio between the third & fourth harmonics?}
  @problem{What interval is defined by the ratio between the fourth & fifth harmonics?}
  @problem{What ratio defines the perfect fifth in just tuning? In equal-tempered tuning?}
  @problem{What's the ratio between the first and second notes in the major scale in just tuning? In equal-tempered tuning?}
  @problem{What's the ratio between the first and third notes in the major scale in just tuning? In equal-tempered tuning?}
  @problem{What's the ratio between the second and fourth notes in the major scale in just tuning? In equal-tempered tuning?}
  @problem{What's the ratio between the second and fifth notes in the major scale in just tuning? In equal-tempered tuning?}
  @problem{What's the ratio between the second and sixth notes in the major scale in just tuning? In equal-tempered tuning?}
  
  @problem{How many half-steps (small steps) make up an octave?})


Develop the program that accepts a frequency and sample rate and returns the
period in samples of the given (pure sine-wave) note.

Develop the program 'aliases?' that accepts a sample rate and two frequencies and
returns 'true' if they alias to the same frequency.

Develop the program that accepts two frequencies and returns the number of times
per second that they "beat" against each other.

How many half-steps are in an octave?

  @problem{What note is six half-steps above D$\sharp$?}

What notes fall between a $D \flat$ and the E above it? Pick at most
one name for each note.

What notes fall between a $D \flat$ and the F above it? Pick at most
one name for each note.

What notes fall between a $D \flat$ and the G above it? Pick at most
one name for each note.

What notes fall between a $A \flat$ and the $F$ below it? Pick at most
one name for each note.

What notes fall between a $A \flat$ and the $E$ below it? Pick at most
one name for each note.

What notes fall between a $A \flat$ and the $E \flat$ below it? Pick at most
one name for each note.

Develop the program that computes the number of half-steps between two given
frequencies.

Develop the program that determines whether two frequencies are within an octave
of each other.

Develop the program that determines whether two frequencies are separated by
an integral number of octaves (e.g.: c2 and c4 -> yes, a4 and b9 -> no).

Develop the program that generates an rsound at a pitch of 300 Hz, using only
fun->mono-rsound, sin, and basic arithmetic.

Develop the program that determines the length of an rsound in seconds, assuming
a sample-rate of 44,100 Hz.
                          

Develop the program that accepts two frequencies and returns the number of times
per second that they "beat" against each other.

@section{Complex Phasor}

;; sampling:

(define period-q
  (let ()
    (define r (+ 10 (random 20)))
    (define s (* 19 r))
 @problem{A tone of @(str r) Hz is sampled at a rate of @(str s) samples
                    per second.
                    What is the length (in samples) of the tone's period?
                    @solution[2]{19 samples}}))

(define aliasing-q
  (let ()
    (define r (+ 30 (random 10000)))
    (define s (- 44100 r))
    @problem{Due to aliasing, different frequencies may produce the same 
 sequence of data when sampled.  What is the next frequency above @(str r)
 Hz that will produce
 the same sequence of samples when sampled at 44100 frames per second?
 @solution[2]{@(str s) Hz}
}))

;; complex phasor:

  @problem{Consider an arbitrary unit vector, $e^{i\theta}$. What is
 the effect of multiplying it by $-1$?}

  @problem{What is the audible effect of multiplying the phasor $e^{i\omega t}$
 by the constant $3+4i$ ?}
  
    @problem{What is the audible effect of multiplying the phasor $e^{i\omega t}$
 by the constant $2i$ ?}

  @problem{What frequencies are eliminated by the inverse comb
           filter described by the transfer
           equation $1 + z^{-4410}$, when the sample rate is 44,100 Hz?}

  
    @problem{What frequencies are reinforced by the inverse comb
           filter described by the transfer
           equation $1 + z^{-16}$, when the sample rate is 8192 Hz?}


 Develop the program that accepts an rsound and uses @racket[overlay], 
 @racket[rs-append*], and @racket[silence] to implement the transfer function
 $1.2 - 3.1 z^{-1} + 1.8 z^{-2}$.
 
 Develop the program that accepts an rsound and uses @racket[overlay], 
 @racket[rs-append*], and @racket[silence] to implement the transfer function
 $0.2 - 0.6 z^{-4}$.
 
@problem{What do you get when you add together two phasors (waves) of the
         same frequency?}

@problem{
Specify two frequencies that, when played together, will ``beat'' four times
  per second.}

@problem{
Specify two frequencies that, when played together, will ``beat'' seven times
  per second.}


@section{Program pieces}

Develop the program that gives the name 'z' to the string "blozzle".
Develop the program that gives the name 'approx-pi' to the number 3.14159.
Develop the program that gives the name 'frank' to the boolean value false.
Develop the program that gives the name 'speakeasy' to the list containing the strings "totem", "camera", and "coarsen".

Write two examples of function applications.
Write two examples of function definitions (no test cases or purpose statements
required).
Write the expression that applies the function 'q' to the arguments 9, 8, and the 
string "ouch".
Write the expression that applies the function 'z' to the three
arguments 9, the result of applying 'g' to 7, and the string "ding".


@section{simple functions}

Develop the program that accepts a number x and computes x^2 + 3.
Develop the program that accepts a number x and computes 4x^3 + 3x^2 + 9
Develop the program that accepts A, B, and C, and x, and computes Ax^2 + Bx + C

Develop the program that returns the length of the longer of two input strings.


Develop the program that returns the smallest of three given numbers.
Develop the program that returns the largest of three given numbers.
Develop the program that returns the median of three given numbers.

  @problem{Develop the @rk{comfortable} program, that accepts a temperature in degrees fahrenheit
 and returns @rk{true} when the temperature is in the range 55 to 75, inclusive. Follow the design 
 recipe, and provide two tests.}

  @problem{Develop the @rk{smaller} program, that accepts two numbers and returns the smaller one.
 Follow the design recipe, and provide two tests.})

                                                    
  @problem{Define the @racket{longer} function that accepts two strings and returns the first string if it is longer,
                      and the second string if it is at least as long, using a @racket{cond} expression.}


  @problem{Define the @racket{second-half} function that returns the second half of a sound. Write one test case.}
  
  @problem{Define the @racket{middle-third} function that returns the middle third of a sound. Write one test case.}



@section{Compound data}

An etude has a title, a composer, and a difficulty. Design a data definition
for etudes, and give three examples.

Develop the 'not-too-difficult' program, that accepts an etude and a difficulty
and returns 'true' when the etude is easier than the given difficulty.

A piano has a maker, a year of construction, and a quality. Design a data
definition for pianos, and give three examples.

Develop the 'old-piano?' program, that accepts a piano and a year of construction
and returns true when the piano was built in or before the given year.

A singer has a height, a weight, a name, and a famousness ranking. Design
a data definition for singers, and give three examples.

Develop the 'short-name-singer?' function, that accepts a singer and returns true
if the singer's name is shorter than 10 characters.

@section{Mixed/self-referential data}

Here's a data definition:

;; a frongle is either 
;; - (make-burble number frongle), or
;; - (make-boogtom string string number)
(define-struct burble (zip zap))
(define-struct boogtom (ag bag zag))

What additional functions are available to programs that 
include this data definition?

Provide the template for a function that accepts a frongle.

Here's a data definition:

;; a predicament is either 
;; - (make-jonquil predicament string), or
;; - (make-mast number)
(define-struct jonquil (flex piece))
(define-struct mast (nectarine))

What additional functions are available to programs that 
include this data definition?

Provide the template for a function that accepts a predicament.

A Bach invention has a name, a key, and a number of measures. Design a piece of
compound data that represents these. Provide two examples of the data.

Develop the @racket[play-difficulty] function that accepts a Bach invention
and returns a number indicating how difficult it is to play.  A piece in C
major has a difficulty equal to its number of measures; all others have a
difficulty of 4 times the number of measures. Be sure to provide a purpose statement,
contract, and test cases, besides the function definition. You may use @racket[string=?]
to compare strings.


@section{Structural recursion over lists}

Provide the data definition for lists of numbers. Write three examples.
Provide the data definition for lists of rsounds. Write three examples.
Provide the data definition for lists of strings. Write three examples.

Provide the template for lists of numbers
Provide the template for lists of rsounds
Provide the template for lists of strings


@subsection{for/list functions}

Develop the program that accepts a list of numbers and returns a new
list containing numbers that are greater by one.

Develop the program that accepts a list of strings and returns a list
of their lengths.

Develop the program that accepts a list of rsounds and returns a list
of the number of frames in each.

Develop the program that accepts a list of pitches and returns a list
of rsounds at the given pitches of 1 second each.

Develop the program that accepts a list of values and a function of
one argument and returns a list containing the result of applying the
given function to each element.



@subsection{Filter-like functions (using for/fold)}

Develop the 'bigger-than-9' program that accepts a list of numbers and
returns the list containing the elements that are strictly larger than
9.

Develop the 'longer-than-fruit" program that accepts a list of strings and
returns the list containing the elements that are longer than the
string "fruit".

Develop the 'filterr' program that accepts a function of one argument
and a list, and returns a list containing the elements of the list for
which the function returns 'true'.

@subsection{Fold-like functions (using for/fold)}:

Develop the program that accepts a list of numbers and returns their sum.
Develop the program that accepts a list of numbers and returns their product.

Develop the program that accepts a list of strings and returns the result
of appending all of the strings together.

Develop the program that accepts a list of non-negative numbers and returns
the largest one. If called with an empty list, the result should be zero.


  
Develop the 'count-pizza' program that accepts a list of strings and
returns the number of times that 'pizza' occurs in it.

Develop the 'count-bigger-than-9' program that accepts a list of numbers
and returns the number of elements that are strictly larger than 9.

Develop the 'count-falses' program that accepts a list of booleans and
returns the number of elements that are the boolean false.

Develop the 'count-satisfying' program that accepts a function of one
argument and a list of anything and returns the number of elements for
which the given argument returns 'true'.

@subsection{Misc}

Develop the 'mean' program, that accepts a list of numbers and computes
their mean.

@subsection{Representations}

What kind of data would you use to represent:
- a pitch?
- a tempo?
- a note? (several possibilities here)
- a sequence of notes?
- a song in a catalog?
- a song review?
- a sampled sound? (what level should this answer be at?)
- a library of sampled sounds?


@section{Structural recursion over arbitrary mixed data}

Here's a data definition:

;; a song is one of
;; - (make-note number number), or
;; - (make-seq song song)
(define-struct note (note-num duration))
(define-struct seq (s1 s2))

Provide the template for this data definition.

Develop the 'first-note' program that accepts a song and returns the
first note in it.

Develop the 'last-note' program that accepts a song and returns the
last note in it.

Develop the 'uniform-duration' program that accepts a song and 
a duration and returns
a new one containing notes of the existing pitches, but which all
have the given duration.

Develop the 'highest-note' program that accepts a song and returns
the highest pitch that it contains.

Develop the 'speed-up-by-n' program that accepts a song and a number
and returns a new song that is faster by the given factor (that is,
the note durations are changed accordingly).

Develop the 'total-duration' method that computes the total duration
of a song.

Assuming the existence of a 'total-duration' method that computes 
the duration of a song, develop the 'note-at-frame' method, that
accepts a song and a frame 'f' and returns the note that is currently
playing at frame 'f'. You may assume that the frame 'f' is less than
the total duration of the given song.

@;{@section{Structural recursion over the natural numbers}

Develop the program that returns the sum of the first 'n' numbers.

Develop the program that returns the product of the first 'n' numbers.

Develop the 'drop' program that accepts a number 'n' and a list of numbers, and
returns the list without the first 'n' members. If the list contains fewer
than 'n' elements, return the empty list.
}

@section{iteration over the natural numbers (using for/fold)}

Develop the program that finds the largest sample value in the left channel
of an rsound. You may use @racket[rs-ith/left] as part of this program.

@section{Using local with mono-signal->rsound}

You may use @racket[rs-ith/left] for all of the following questions.

Develop the program that scales a given rsound by a given number 'n'; that is,
each sample is multiplied by n. You may assume that both channels of the rsound
are identical.

Develop the 'rsound-stretchx3' program that stretches an rsound to three
times its original length by duplicating each sample three times.

Develop the 'rsound-reverse' program that reverses an rsound. You may assume
that both channels of the rsound are identical.

Develop the 'fade-in' program that accepts an rsound and produces a new rsound
where each frame's sample is multiplied by a volume that increases from zero
at the first frame up to 1.0 at the last frame.

Develop the 'fade-out' program that accepts an rsound and produces a new rsound
where each frame's sample is multiplied by a volume that decreases from 1.0
at the first frame down to 0.0 at the last frame.

@problem{Define the @rk{swell-tone} function, that accepts a number of frames f
 and produces a sound that is a sine wave at a frequency of 352 Hz whose amplitude
 increases steadily from 0.0 at frame 0 up to 1.0 at frame $f-1$, where it stops.
 
 Hint: you'll need a @rk{local} for this. 
 
 Use the design recipe, including the purpose statement, contract, and one test case.}


  
;; MISC
  
  @problem{Here's a short program:
 @racketdisplay{
(define (f x) (+ x (* x 3))) 
(f 19)}
 Write down the next (first) step in evaluating this program:}

  @problem{Define the @rk{capture-add} function, that accepts a number @rk{n}
 and returns a function that accepts one argument and adds it to @rk{n}.
 Follow the design recipe. Provide one test case.}

  
