#! /usr/bin/csi -s

;notes: in the book example (make-from-real-imag x y)  and the subsquent 2.75
; basicaly returns a data structure of sorts with methods (operations) that you pass 

; 2.75

(define (make-from-mag-ang mag ang)
  (define (dispatch op)
    (cond ((eq? 'magnitude op) mag)
          ((eq? 'angle op) ang)
          ((eq? 'real-part op) (* mag (cos ang)))
          ((eq? 'imag-part op) (* mag (sin ang)))
          (else (error "Unknown op: MAKE-FROM-MAG-ANG" op))))
  dispatch)

;2.76

; new types: either seems to be fine, message passing just means you give
; a new constructor, data-directed means you add a new column
; new operations: either seems to be fine too, message passing means everybody
; needs to update their constructors, data-directed means updated packages
; and a new row is added to the table
; in either case, generic operations with explicit dispatch sounds like the most
; painful to use
