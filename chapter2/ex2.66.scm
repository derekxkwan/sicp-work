#! /usr/bin/csi -s


(define (lookup given-key set-of-records)
  (let ((curentry (entry set-of-records)))
    (let ((curkey (key curentry)))
      (cond ((null? set-of-records) #f)
            ((= given-key curkey) curentry)
            ((< given-key curkey) (lookup given-key (left-branch set-of-records)))
            (else (lookup given-key (right-branch set-of-records))))
      )))
