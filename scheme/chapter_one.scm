(define (find_sqrt x guess prev_guess) 
	(display guess) 
	( if (< (abs (- prev_guess guess)) (/ prev_guess 1000))
		guess 
		(find_sqrt x (/ (+ guess (/ x guess)) 2.0) guess)
	)
)

(define (sqrt x) (find_sqrt x 1 0))


(define (find_cbrt x guess prev_guess) 
	(display guess) 
	( if (< (abs (- prev_guess guess)) (/ prev_guess 1000))
		guess
		(find_cbrt x (/ (+ (/ x (* guess guess)) (* 2 guess)) 3 ) guess)
	)
)

 
(define (cbrt x) (find_cbrt x 1.0 0.0))
