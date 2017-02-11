#! /usr/bin/guile-2.0 --no-auto-compile
!#

(list 1 (list 2 (list 3 4)))

; ( 1 ( 2 (3 4)))
;this will be a pain to draw out so i'll just describe it...
; since they're all lists, they all have nils at the and each list branches off ...

; [ |-]->[ |\] 
;  V      V
;  1     [ |-]->[ |\]
;         V      V
;         2     [ |-]->[ |\]
;                V      V
;                3      4
; tree/branches are similar but just omit the nil slashes
; if they wree just cons, you wouldn't have the branching off and 
; nil slashes and together they'd be just one proper list
