
; 2.83

; tower = integer -> rational -> real -> complex

(define (project x) (apply-generic 'project x))

(put 'project 'complex (lambda (x) (real-part x)))

; kinda hard to go from real to rational so let's just skip down to integer
(put 'project 'real (lambda (x) (round x)))

(put 'project 'rational (lambda (x) (round (/ (numer x) (denom x)))))


(define (apply-generic op . args)
  (define type-tower '(integer rational real complex))
  (define (can-drop? arg)
    (let ((curtype (type-tag arg)))
      (if (eq? 'integer curtype) #f
        ; can't remember exactly that the generic equals is...
        (equ? (raise (project arg)) arg))))
  (define (drop arg)
    (if (not (can-drop? arg)) arg
      (drop (project arg))))
  (define (error-out type-tags)
    (error "No method for these types" (list op type-tags)))
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc (apply proc (map contents args))
        (if (= (length args) 2)
          (let ((a1 (car args))
                (a2 (cadr args)))
            (let ((type1-drop (type-tag (drop a1)))
                  (type2-drop (type-tag (drop a2))))
              (let ((proc-drop (get op (list type1-drop type2-drop))))
                (if proc-drop (apply proc-drop (map contents (list a1 a2)))
                  (error-out type-tags))))))))))

; again, can't run this code  but the idea is to fall back to dropped 
; types and test again, perhaps with more can make this a recursive call
; using can-drop?
