#! /usr/bin/guile-2.0 --no-auto-compile
!#

; church numerals!

;this returns a proc with one arg f
; f also takes one argt but according to the lambda x, isn't applied
; so ((zero abs) -3) still returns -3, ((zero 3) -3) works and returns -3;
;(define zero2 (lambda (f) (lambda (x) (f x)))) would actually apply the function;
(define zero (lambda (f)
               (lambda (x) x)))

; this takes argt n
; returns a proc with one arg f
; f like zero takes one arg
; the lambda x applies f to ((n f) x)
; 
(define (add-1 n) (lambda (f)
    (lambda (x) (f ((n f) x)))))

;(add-1 zero) -> (lambda (f) (lambda (x) (f ((zero f) x)))) 
; -> (lambda (f) (lambda (x) (f ((lambda (x) x) x))))
; -> (lambda (f) (lambda (x) (f x)))
; so this applies f once and can be one

(define one (lambda (f) (lambda (x) (f x))))

; (add-1 one) -> (lambda (f) (lambda (x) (f ((one f) x))))
; -> (lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
; -> (lambda (f) (lambda (x) (f (f x))))
; so this applies f twices and can be two

(define two (lambda (f) (lambda (x) (f (f x)))))

; now we want an addition procedure for church numberals without using add-1
; so adding something that applies f m times to something n times -> m+n times
; let's copy the format of add-1

(define (church-add m n) (lambda (f)
    (lambda (x) ( (m f) ((n f) x)))))
