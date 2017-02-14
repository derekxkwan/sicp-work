#lang sicp
(#%require sicp-pict)

;a to do

;b

(define (split orig recurse)
  (lambda (painter n)
    (if (= n 0) painter
        (let ((smaller ((split orig recurse) painter (- n 1))))
          (orig painter (recurse smaller smaller))))
    ))

(define up-split (split below beside))
(define right-split (split beside below))

(define (corner-split2 painter n)
  (if (= n 0) painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left up)
              (bottom-right right)
              (corner (corner-split2 painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(paint (corner-split2 einstein 3))

;c

(define (flip-vert painter)
  ((transform-painter (make-vect 0.0 1.0) (make-vect 1.0 1.0) (make-vect 0.0 0.0))painter))

(define (squash-inwards painter)
  ((transform-painter (make-vect 0 0) (make-vect 0.65 0.65) (make-vect 0.35 0.65))
   painter))


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

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (square-limit painter n)
  (let ((combine4 (square-of-four rotate180 flip-vert flip-horiz identity)))
        (combine4 (corner-split2 painter n))))

(paint-hires (square-limit einstein 3))
