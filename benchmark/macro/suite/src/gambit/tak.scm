#!gsi-script -:d0
;;; TAK -- A vanilla version of the TAKeuchi function.

(define (tak x y z)
  (if (fx>= y x)
      z
      (tak (tak (fx- x 1) y z)
           (tak (fx- y 1) z x)
           (tak (fx- z 1) x y))))

(define (main . args)
  (let* ([x (read)]
	 [y (read)]
	 [z (read)])
    (pretty-print (tak x y z))))
