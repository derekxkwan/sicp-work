#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;a
(define (left-branch mobile)
  (car mobile))

; we need to remember that lists are technically (cons a (cons b #nil))
(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))

;b

(define (is-weight? branch)
  (number? (branch-structure branch)))

(define (branch-weight branch)
  (let ((attached (branch-structure branch)))
    (if (number? attached)
      attached
      (+ (branch-weight (left-branch attached))
         (branch-weight (right-branch attached)))
      ))
  )

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

;c

(define (branch-torque branch)
  (* (branch-weight branch) (branch-length branch)))

(define (is-balanced? mobile)
  (if (is-weight? mobile) #t
    (let ((bL (left-branch mobile))
          (bR (right-branch mobile)))
      (and (= (branch-torque bL)
              (branch-torque bR))
           (is-balanced? bL)
           (is-balanced? bR)))
    ))
