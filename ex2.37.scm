#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))


(define (accumulate-n op init seqs)
  (if (null? (car seqs)) #nil
    (cons (accumulate op init (map car seqs))
          (accumulate-n op init (map cdr seqs)))
    )
  
  )

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m))

;n(ij) = m(ji), basically columns become rows and rows become columns
; so we are given row vectors and we want them as column vectors
(define (transpose mat)
  (accumulate-n cons #nil mat))

;((1 2 3) (4 5 6) (7 8 9) (10 11 12)) -> ((1 4 7 10) (2 5 8 11) (3 6 9 12))

;a11 a12 a13 * b11 b12 b13 (let's transpose b) ->
;a21 a22 a23   b21 b22 b23
;a31 a32 a33   b31 b32 b33

;a1: a11 a12 a13 *t b1t: b11 b21 b31 -> (dot-product a1 b1t) (dot-prod a1 b2t) (dot-prod a1 b3t)
;a2: a21 a22 a23    b2t: b12 b22 b32    (dot-prod a2 b1t) (dot-prod a2 b2t) (dot-prod a3 b3t)
;a3: a31 a32 a33    b3t: b13 b23 b33    (dot-prod a3 b1t) (dot-prod (a3 b2t) (dot-prod a3 b3t)

;map applies proc to every entry of m (which is every row vector)
; dot-prod is a float, matrix*vector is a row vector
; dot-prod cols x is dot prod col vectors of b with row 1 of m, row 2 of m, row 3 of m...
; so first list is a row vector resulting from a1 times n transpose. etc
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x) (matrix*vector cols x)) m)))
