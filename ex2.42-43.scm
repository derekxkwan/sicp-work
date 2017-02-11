#! /usr/bin/guile-2.0 --no-auto-compile
!#

;previous and book work

(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (fold-right op initial (cdr sequence)))))

(define (flatmap proc seq)
  (fold-right append #nil (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
    #nil
    (cons low (enumerate-interval (+ low 1) high))))

; new work

(define (queens board-size)
  (define empty-board #nil)
  (define (new-queen row col)
    (cons row col))
  (define (adjoin-position row col rest)
    (cons (new-queen row col) rest))
  (define (row-val position)
    (car position))
  (define (col-val position)
    (cdr position))
  ;safe positions are the ones which do not share a col or row
  ;with other queens and can't be reached by their (+ ix posx)
  ; (+iy posy)
  (define (safe? col positions)
    (define (same-diag? q1 q2)
      ; if on the same diag, (/ (- y2 y1) (- x2 x1)) is 1 or -1
      ; meaning ( abs (- x2 x1)) is the same as ( abs (- y2 y1))
      (= (abs (- (row-val q2) (row-val q1)))
         (abs (- (col-val q2) (col-val q1))))
      )
    (define (attackable? q1 q2)
      (or (same-diag? q1 q2)
          (= (row-val q1) (row-val q2))
          (= (col-val q1) (col-val q2))))
    (define (safe-iter new-q others)
      (cond ((null? others) #t)
            ((attackable? new-q (car others)) #f)
            (else (safe-iter new-q (cdr others)))
            ))
    ; (car positions) = new queen
    (safe-iter (car positions) (cdr positions))
    )
  (define (queen-cols k)
    (if (= k 0) (list empty-board)
      (filter (lambda (positions) (safe? k positions))
              (flatmap (lambda (rest-of-queens)
                         (map (lambda (new-row)
                                (adjoin-position new-row k rest-of-queens))
                              (enumerate-interval 1 board-size)))
                       (queen-cols (- k 1))))))
  (queen-cols board-size))

; ex2.43

;switching lambda (rest of queens) and lambda (new-row) and also 
; then necessarily (queens-cols (- k 1) and (enumerate-interval 1 board-size)
; is bad because then you're reevaluating queens-cols each time which is much
; much heavier than enumerate-interval.

