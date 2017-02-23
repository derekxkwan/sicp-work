#! /usr/bin/csi -s

;book stuff

(define (make-leaf symbol weight) (list 'leaf symbol weight))
(define (leaf? object) (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree) (list (symbol-leaf tree))
    (caddr tree)))
(define (weight tree)
  (if (leaf? tree) (weight-leaf tree) (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits) '()
      (let ((next-branch (choose-branch (car bits) current-branch)))
        ; if we hit a leaf, we found the symbol! keep going no matter what
        (if (leaf? next-branch) (cons (symbol-leaf next-branch)
                                      (decode-1 (cdr bits) tree))
          (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit: CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs) '()
    (let ((pair (car pairs)))
      (adjoin-set (make-leaf (car pair) ;symbol
                             (cadr pair)) ;frequency
                  (make-leaf-set (cdr pairs))))))

; 2.67

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
             (make-code-tree
                        (make-leaf 'B 2)
                        (make-code-tree
                          (make-leaf 'D 1)
                          (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(display (decode sample-message sample-tree)) (newline)

; (A D A B B C A)

; 2.68

(define (encode message tree)
  (if (null? message) '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

(define (encode-symbol sym tree)
  (define (in-branch? sym branch)
    (if (leaf? branch) (eq? sym (symbol-leaf branch))
      (memq sym (symbols branch))))
  (define (encode-iter node)
    (if (leaf? node) '()
      (let ((lb (left-branch node))
            (rb (right-branch node)))
        (cond ((in-branch? sym lb) (cons 0 (encode-iter lb)))
              ((in-branch? sym rb) (cons 1 (encode-iter rb)))
              (else '())))))
  (encode-iter tree))

; 2.69


(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (cond ((null? leaf-set) '())
        ((= (length leaf-set) 1) (car leaf-set))
        (else (let ((lL (car leaf-set))
                    (rL (cadr leaf-set))
                    (rest (cddr leaf-set)))
                (successive-merge (adjoin-set (make-code-tree lL rL) rest))
                ))))

; 2.70

(define rock-pairs (list (list 'A 2) (list 'BOOM 1) (list 'GET 2) (list 'JOB 2)
                         (list 'SHA 3) (list 'NA 16) (list 'WAH 1) (list 'YIP 9)))

(define rock-tree (generate-huffman-tree rock-pairs))

(define rock-song '(GET A JOB SHA NA NA NA NA NA NA NA NA GET A JOB
                        SHA NA NA NA NA NA NA NA NA WAH YIP YIP
                        YIP YIP YIP YIP YIP YIP YIP SHA BOOM))

(define rock-encode (encode rock-song rock-tree))

; bits = 5, 
; bits needed for encoding = 84
; fixed-length for 8th symbol,.. log 2 8 = 3 bits
; 3 * 36 = length of rock song = 188

; 2.71


; for n =5: we have (a 1) (b 2) (c 4) (d 8) (e 16)
; -> (ab 3) (c 4) (d 8) (e 16)
; -> (abc 7) (d 8) (e 16)
; -> (abcd 15) (e 16)
; -> (abcde 16)
; so we need 4 bits = n -1 at most, 1 bit at least

; 2.72
; the bulk of the work is in encode-symbol which uses memq which
; is O(n), so called twice per call, 2*n, since everytime we're merging
; two leaves until we end with one leaf, there's n-1 calls, so that's
; O(n) * n-1 = O(n^2)
