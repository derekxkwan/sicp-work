#! /usr/bin/guile-2.o -s 
!#
(A 1 10)
(A 0 (A 1 9))
(A 0 (A 0 (A 1 8)))
;... and so on
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
;... and so on
(expt 2 10)
1024

;.......
(A 2 4)
(A 1 (A 2 3))
(A 1 (A 1 (A 2 2)))
(A 1 (A 1 (A 1 (A 2 1))))
(A 1 (A 1 (A 1 2)))
(A 1 (A 1 (A 0 (A 1 1))))
(A 1 (A 1 (A 0 2)))
(A 1 (A 1 4))
(A 1 (A 0 (A 1 3 )))
(A 1 (A 0 (A 0 (A 1 2))))
(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
(A 1 (A 0 (A 0 (A 0 2))))
(A 1 (A 0 (A 0 4)))
(A 1 (A 0 8))
(A 1 16)
;..... and so on
(expt 2 16)
65536

;.....
(A 3 3)
(A 2 (A 3 2))
(A 2 (A 2 (A 3 1)))
(A 2 (A 2 2))
;.... and so on
(A 2 4)
;.... and so on
65536

;.......
(define (f n) (A 0 n)) ; 2*n
(define (g n) (A 1 n)) ; (expt 2 n)
(define (h n) (A 2 n)) ; (A 1 (expt 2 n)) -> (expt 2 (expt 2 n))

