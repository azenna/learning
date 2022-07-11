;1.1

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

;1.2

(define (factorial n) (if (= n 1) 1 (* n (factorial (- n 1)))))

(define (factorial2 n)
	(define (iter product counter)
		(if (> counter n)
			product
			(iter (* counter product) (+ counter 1))
		)
	)
	(iter 1 1)
)

;does not keep a running total and grows linearly
;needs to remember chain of operations
;linear recursive process 
(define (fibonacci n)
	(if (or (= n 1) (= n 2))
		n
		(+ (fibonacci (- n 2)) (fibonacci (- n 1)))
	)
)

;keeps a running total does not grow
;linear iterative process
(define (fibonacci2 n)
	(define (iter total prev_total counter)
		(if (= n counter)
			total
			(iter (+ total prev_total) total (+ counter 1))
		)
	)
	(iter 1 1 1)
)

;how many ways can you change a certain amount of money
(define (change amount kinds_of_coins)
		(cond
			((= amount 0) 1)
			((or (< amount 0) (= kinds_of_coins 0)) 0)
			(else (+ 
				(change amount (- kinds_of_coins 1))
				(change (- amount
						(coin_switch kinds_of_coins))
					kinds_of_coins
				)
			)
			)
		)
)

(define (coin_switch kinds)
	(cond 
		((= kinds 1) 1)
		((= kinds 2) 5)
		((= kinds 3) 10)
		((= kinds 4) 25)
		((= kinds 5) 50)
	)
)

(define (ex_111 n)
	(if (< n 3)
		n
		(+ (ex_111 (- n 1))
			(* 2 (ex_111 (- n 2)))
			(* 3 (ex_111 (- n 3)))
		)
	)
)

(define (ex_111_iter n counter total1 total2 total3)
	( if (> counter n) total1
		(ex_111_iter n (+ counter 1)
			(if (< counter 3) counter (+ total1 (* 2 total2) (* 3 total3)))
			total1
			total2)))

; thought I was an idiot while reading through book, couldn't make heads or tails
; of the description, but after reading online trying to figure out what they wanted
; it was much easier
(define (pascal row col)
	(if (or (= col 0) (= col row))
		1
		(+ (pascal (- row 1) col) (pascal (- row 1) (- col 1)))))

(define (sine_approximation x)
  (if (< (abs x) .01) x
      (- (* 3 (sine_approximation (/ x 3.0))) (* 4 (expt (sine_approximation (/ x 3.0)) 3)))))

(define (fast_expt b o n)
  (cond ((= n 1) b)
        ((not (= 0 (remainder n 2))) (fast_expt (* b o) (- n 1)))
        (else (fast_expt (* b b) (/ n 2)))))

(define (exptt b n)
  (fast_eppt b b n))

(define (multiply a b)
  (cond ((= b 1) a)
        ((not (= 0 (remainder b 2))) (+ a (multiply a (- b 1)))) 
	(else (multiply (* a 2) (/ b 2)))))

        
