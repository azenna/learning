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

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((= 0 (remainder count 2))
         (fib-iter a
                   b
                   (+ (* p p) (* q q))
                   (+ (* 2 q p) (* q q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))        

(define (greatest_common_divisor a b)
  (if (= 0 b)
      a
      (greatest_common_divisor b (remainder a b))))

(define (next x)
  (if (= x 2) 3 (+ x 2)))

(define (smallest_divisor n)
  (find_divisor n 2))

(define (find_divisor n test)
  ( cond ((= (remainder n test) 0) test)
         ((> (* test test) n) n)
         (else (find_divisor n (next test)))))

(define (is_prime n)
	(= n (smallest_divisor n)))

(define (expmod n e m)
  (cond ((= e 0) 1)
        (else
         (remainder (* n (expmod n (- e 1) m)) m))))
     
(define (fermat_test n)
  (if (= (expmod (- n 1) n n) (- n 1)) 
      #t
      #f))

(define (timed_prime_test n)
  (newline)
  (display n)
  (start_prime_test n (runtime)))

(define (start_prime_test n start_time)
  (if (is_prime n)
      (report_prime (- (runtime) start_time))
      #f))

(define (report_prime elapsed_time)
  (display " *** ")
  (display elapsed_time)
  #t)

(define (search_for_primes start count)
  (cond ((= count 3))
        ((is_prie start) (search_for_primes (+ start 1) (+ count 1)))
        (else (search_for_primes (+ start 1) count))))

(define (miller-rabin-test n)
  (define (random n) (random-integer n))
  (define (expmod base exp m)
    (define (square-mod x) (remainder (* x x) m))
    (define (square-signal-root x)
     (display x)
     (newline)
     (if (and 
	  (not (or (= 1 x) (= x (- m 1))))
	  (= 1 (square-mod x)))
      0
      (square-mod x)))
    (cond ((= exp 0) 1)
     ((even? exp) (square-signal-root (expmod base (/ exp 2) m)))
     (else
      (remainder (* base (expmod base (- exp 1) m))
                 m))))  
  (define (try-it a)
   (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
	(else #f)))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

(define (cube x) (* x x x))

(define (sum_cubes a b) (sum cube a inc b))

(define (inc x) (+ x 1))

(define (sum_ints a b) (sum + a inc b))

(define (pi_sum a b)
  (define (pi_term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi_next x) (+ x 4))
  (sum pi_term a pi_next b))

(define (pi_approx d)
  (* 8 (pi_sum 1 d))) 

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(define (simpsons f a b n)
  (define h (/ (- b a) n))
  (define (add_two_h x) (+ x h h))

  (* (/ h  3) (+ (f a) (f b) (* 2 (sum f a add_two_h b)) (* 4 ( sum f (+ a h) add_two_h b)))))

(define (sum_iter term a next b)
  (define (iter a result)
    (if (> a b)
        result 
        (iter (next a) (+ result (term a)))))
   (iter a 0))

(define (sum_iter_ints a b) (sum_iter + a inc b))

(define (product a b term next)
  (if (> a b)
      1
      (* (term a) (product (next a) b term next))))

(define (product_iter a b term next accumulated)
  (if (> a b)
      accumulated
      (product_iter (next a) b term next (* accumulated (term a)))))

(define (factorial b) (product 1 b + (lambda (x) (+ x 1)))) 

(define (pi_prod_approx n)
  (* (/ (* 4 (+ n 1)) (square 3)) (product_iter 2 n (lambda (x) (/ (square (* 2 x)) (square (+ 1 (* 2 x))))) inc 1) 4.0))

(define (accumulate combiner last a b term next)
  (if (> a b)
      last
      (combiner (term a) (accumulate combiner last (next a) b term next))))

(define (sum a b term next) (accumulate (lambda (a b) (+ a b)) 0 a b term next))
(define (prod a b term next) (accumulate * 1 a b term next))

(define (accumulate_iter combiner a b term next accumulated)
  (if (> a b)
      accumulated
      (accumulate_iter combiner (next a) b term next (combiner accumulated (term a)))))

(define (sum_iter a b term next) (accumulate_iter + a b term next 0))

(define (sum_iter_ints a b) (sum_iter a b + (lambda (x) (+ x 1))))

(define (filter_accumulate combiner last a b term next filter)
  (cond ((> a b) last)
        ((filter a)
         (combiner (term a) (filter_accumulate combiner last (next a) b term next filter)))
        (else
         (filter_accumulate combiner last (next a) b term next filter))))

(define (sum_squares_prime a b)
  (filter_accumulate + 0 a b square inc is_prime))

(define (ex_133 n)
  (filter_accumulate + 0 1 n + inc (lambda (x) (= 1 (greatest_common_divisor x n)))))

(define (close_enough x y) (< (abs (- x y)) .0001))
(define (fixed_point f first_guess)
  (let ((next (f first_guess)))

  (if (close_enough first_guess next)
      first_guess
      (fixed_point f next))))

(define golden_ratio (fixed_point (lambda (x) (+ 1 (/ 1 x))) 1.0))

