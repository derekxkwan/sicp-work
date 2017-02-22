#! /usr/bin/csi -s

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))


; 2.63
(define fig2.16.1 (list 7 (list 3 (list 1 '() '()) (list 5 '() '()))
                        (list 9 '() (list 11 '() '()))))

(define fig.2.16.2 (list 3 (list 1 '() '()) (list 7 (list 5 '() '()) (list 9 '()
                        (list 11 '() '())))))

(define fig.2.16.3 (list 5 (list 3 (list 1 '() '()) '()) (list 9 (list 7 '() '())
                        (list 11 '() '()))))


; recurces on both sides of the tree
(define (tree->list-1 tree)
  (if (null? tree) '()
    (append (tree->list-1 (left-branch tree))
            (cons (entry tree) (tree->list-1 (right-branch tree))))))

;also recurses on both sides of tree, but drags along copies of it
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree) result-list
      (copy-to-list (left-branch tree)
                    (cons (entry tree) (copy-to-list (right-branch tree)
                                                     result-list)))))
  (copy-to-list tree '()))

;both should return the same list since each are doing recursive calls on both sides and putting the right branch to the right of entry, left to the left of the entry

;1st uses append and cons, the second just uses cons

;append is defined as:
#| (define (append list1 list2)
     (if null? list1) list2
     (cons (car list1) (append (cdr list1) (list2))))
|#

; so append goes through the entire second list, since the length of the list ISN'T
; n each time but halved each time (granted the tree is balanced), so while
; tree->list-2 is O(n), tree->list-1 is O(n log n)


; 2.64

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
    (cons '() elts)
    (let ((left-size (quotient (- n 1) 2)))
      (let ((left-result (partial-tree elts left-size)))
        (let ((left-tree (car left-result))
              (non-left-elts (cdr left-result))
              (right-size (- n (+ left-size 1))))
          (let ((this-entry (car non-left-elts))
                (right-result (partial-tree (cdr non-left-elts) right-size)))
            (let ((right-tree (car right-result))
                  (remaining-elts (cdr right-result)))
              (cons (make-tree this-entry left-tree right-tree)
                    remaining-elts))))))))

; a: partial-tree splits the elts into (n-1)/2 (-1 for the middle elt)
; and then the rest. the first bit is is then recursed upon by partial-tree. the
; leftovers from this call (minus the first elt for the middle) are sent to
; a second recursive call with size being (right-size is (n - (left-size + 1)) to
; account for perhaps (n-1) being odd (and having an uncounted remainder)
;                 5
;               /   \
;              1     9
;             / \   / \ 
;                3 7  11

; b: T(n) = a*T(n/b) + f(n); a = size of problem
; a = number of subproblems in the recursion, n/b size of each subproblem, f(n) = 
; extra work. a = 2 n/b = n/2, f(n) = quotient, subtraction,  2 cars, 2 cdrs = 
; constant work. T(n) = 2*T(n/2) + O(1) = O(n)

; 2.65

; OLD WORK FOR HELP

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
    '() (let ((x1 (car set1)) (x2 (car set2)))
          (cond ((= x1 x2)
                 (cons x1 (intersection-set (cdr set1)
                                            (cdr set2))))
                ((< x1 x2) (intersection-set (cdr set1) set2))
                ((< x2 x1) (intersection-set set1 (cdr set2)))))))

(define (adjoin-set-ordered x set)
  (if (null? set) (list x)
    (let ((cur (car set)))
      (cond ((< x cur) (cons x set)) ; can't be in set
            ((= x cur) set) ; already in set
            (else (cons cur (adjoin-set-ordered x (cdr set))))
            ;try again against next elt of set
                        ))))
(define (union-set-ordered s1 s2)
  (define (union-ord-iter set result)
    (cond ((null? set) result)
          ((null? result) set)
          (else 
            (let ((ins (car set)) ;what we're trying to insert
                  (cmp (car result))) ;what we're comparing to
              (cond ((< ins cmp) (cons ins (union-ord-iter (cdr set) result)))
                    ; ins is guaranteed to be in
                    ((= ins cmp) (union-ord-iter (cdr set) result))
                    ; ins can't be in
                    (else (cons cmp (union-ord-iter set (cdr result))))
                    ;cmp guaranteed to be in 
                    )))))
    (union-ord-iter s1 s2))
;OLD WORK END

(define (union-tree t1 t2)
  (let ((s1 (tree->list-2 t1))
        (s2 (tree->list-2 t2)))
    (list->tree (union-set-ordered s1 s2))))


(define (intersection-tree t1 t2)
  (let ((s1 (tree->list-2 t1))
        (s2 (tree->list-2 t2)))
    (list->tree (intersection-set s1 s2))))

