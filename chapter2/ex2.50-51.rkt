#lang sicp

(#%require sicp-pict)

;the book's given transform-painter takes a painter and its frame of reference
; then you pass in a new frame of reference and it returns a new painter with the
; old frame of reference tranformed wrt the new one

;also note that frames are specified by an origin and the edge vectors in relation
; to the origin

;the argts of transform-painter takes the ENDS of the vectors, irrespective
; of the given origin

#| this is how the book defines flip-vert, except racket throws an error...
(define (flip-vert painter)
  ((transform-painter painter (make-vect 0.0 1.0) (make-vect 1.0 1.0) (make-vect 0.0 0.0))))
|#

(define (flip-vert painter)
  ((transform-painter (make-vect 0.0 1.0) (make-vect 1.0 1.0) (make-vect 0.0 0.0))painter))
;(paint einstein)
;(paint (flip-vert einstein))

(define (squash-inwards painter)
  ((transform-painter (make-vect 0 0) (make-vect 0.65 0.65) (make-vect 0.35 0.65))
   painter))

;(paint (squash-inwards einstein))

;EXERCISE 2.50

(define (flip-horiz painter)
  ((transform-painter
    (make-vect 1 0) (make-vect 0 0) (make-vect 1 1))painter))

(define (rotate90 painter)
  ((transform-painter
    (make-vect 1 0) (make-vect 1 1) (make-vect 0 0)) painter))

(define (rotate180 painter)
  (rotate90 (rotate90 painter)))

(define (rotate270 painter)
  (rotate90 (rotate180 painter)))

;testing
(paint einstein)
(paint (flip-horiz einstein))
(paint (rotate90 einstein))
(paint (rotate180 einstein))
(paint (rotate270 einstein))

;EXERCISE 2.51

;note that transform-painter returns a painter which in turn takes a frame
; hence the need for the lambda frame
(define (beside1 painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left ((transform-painter (make-vect 0 0) split-point
                                            (make-vect 0 1)) painter1))
          (paint-right ((transform-painter split-point (make-vect 1 0)
                                         (make-vect 0.5 1)) painter2)))
      (lambda (frame) (paint-left frame) (paint-right frame))
      )))


(define (below1 painter1 painter2)
  (let ((split-point (make-vect 0 0.5)))
    (let ((paint-bottom ((transform-painter (make-vect 0 0) (make-vect 1 0)
                                            split-point) painter1))
          (paint-top ((transform-painter split-point (make-vect 1 0.5)
                                         (make-vect 0 1)) painter2)))
      (lambda (frame) (paint-bottom frame) (paint-top frame))
      )))

(define (below2 painter1 painter2)
  (rotate90 (beside1 (rotate270 painter1) (rotate270 painter2))))

(paint (beside1 einstein diagonal-shading))
(paint (below1 einstein diagonal-shading))
(paint (below2 einstein diagonal-shading))




      
  