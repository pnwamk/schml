#!/usr/bin/gsi -:d0

(declare
  (standard-bindings)
  (fixnum))

(define (main)
  (letrec ([create
	    (lambda (l1 l2)
	      (let ([x (make-vector l1 (make-vector l2 0))])
		(begin
		  (let loop1 ([i 0])
		    (if (< i l1)
			(begin
			  (let ([xi (make-vector l2 0)])
			    (begin
			      (let loop2 ([j 0])
				(if (< j l2)
				    (begin
				      (vector-set! xi j (+ j i))
				      (loop2 (+ j 1)))))
			      (vector-set! x i xi)))
			  (loop1 (+ i 1)))))
		  x)))]
	   [mult
	    (lambda (x x1 x2 y y1 y2)
	      (let ([r (make-vector x1 (make-vector y2 0))])
		(begin
		  (let loop1 ([i 0])
		    (if (< i x1)
			(begin
			  (let ([ri (make-vector y2 0)])
			    (begin
			      (let loop2 ([j 0])
				(if (< j y2)
				    (begin
				      (let loop3 ([k 0])
					(if (< k y1)
					    (begin
					      (vector-set! ri j
							   (+ (vector-ref ri j)
							      (* (vector-ref (vector-ref x i) k)
								 (vector-ref (vector-ref y k) j))))
					      (loop3 (+ k 1)))))
				      (loop2 (+ j 1)))))
			      (vector-set! r i ri)))
			  (loop1 (+ i 1)))))
		  r)))])
    (let* ([size (read)]
	   [ar size]
	   [ac size]
	   [br size]
	   [bc size]
	   [a (create ar ac)]
	   [b (create br bc)]
	   ;; Why is there a box here? -andre
	   [bx (box 0)])
      (begin
	(set-box! bx
		  (vector-ref
		   (vector-ref (mult a ar ac b br bc)
			       (- ar 1))
		   (- ac 1)))
	(display (unbox bx))))))
