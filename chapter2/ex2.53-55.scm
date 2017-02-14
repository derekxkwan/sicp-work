#! /usr/bin/guile-2.0 --no-auto-compile
!#

#|
; EXERCISE 2.53
(list 'a 'b 'c) ;(a b c)
(list (list 'george)) ; ((george))
(cdr '((x1 x2) (y1 y2))) ; ((y1 y2)), double () since it's a list
(cadr '((x1 x2) (y1 y2))) ; (y1 y2)
(pair? (car '(a short list)))  ;#f, car of list is a which is a variable
(memq 'red '((red shoes) (blue socks))) ; #f, (red shoes) is not the same as 'red

(memq 'red (red shoes blue socks)) ; (red shoes blue socks)
|#

; EXERCISE 2.54

(define (equal? a b)
  (let ((a1 (car a)) (b1 (car b)))
    (if (not (and (pair? a1) (pair? b1)))
    (eq? a1 b1)
    (equal? (car a1) (car b1))
    )))

; EXERCISE 2.55

; (car ''abracadabra) is (car (quote (quote abracadabra)))
; (quote something) something means list so (quote (quote something))
; is (list quote something) essentially so quote is the first elt 
; of the list


