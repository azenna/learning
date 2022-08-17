(define (print x) (display x) (newline))

(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

(define (square x) (* x x))

(define (find_sqrt n x)
  (let ((next (/ (+ x (/ n x)) 2.0)))
       (if (< (abs (- x next)) (/ x 1000))
          x
          (find_sqrt n next))))

(define (sqrt x) (find_sqrt x x))

(define (make_rat n d)
  (let ((g (abs (gcd n d))))
    (cons (/ (* (abs n) (/ (abs n) n) (/ (abs d) d)) g) (/ (abs d) g))))

(define numer car)
(define denom cdr)

(define (make_point x y)
  (cons x y))

(define x_point car)
(define y_point cdr)

(define (print_point p)
  (newline)
  (display "(")
  (display (x_point p))
  (display ", ")
  (display (y_point p))
  (display ")"))

(define (make_line p1 p2)
  (cons p1 p2))

(define start_segment car)
(define end_segment cdr)

(define (mid_point line)
  (make_point (/ (+ (x_point (start_segment line)) (x_point (end_segment line))) 2)
              (/ (+ (y_point (start_segment line)) (y_point (end_segment line))) 2)))

(define (length line)
  (sqrt (+ (square (abs (- (x_point (end_segment line)) (x_point (start_segment line)))))
           (square (abs (- (y_point (end_segment line)) (y_point (start_segment line))))))))

(define (rectangle v1 v2)
  (cons v1 v2))

(define vert1 car)
(define vert2 cdr)

(define (perimeter rect)
  (+ (* 2 (abs (- (x_point (vert2 rect)) (x_point (vert1 rect)))))
     (* 2 (abs (- (y_point (vert2 rect)) (y_point (vert1 rect)))))))

(define (area rect)
  (* (abs (- (x_point (vert2 rect)) (x_point (vert1 rect))))
     (abs (- (y_point (vert2 rect)) (y_point (vert1 rect))))))

(define (make_rect2 seg perp_seg)
  (cons seg perp_seg))

(define (perimeter2 rect)
  (* 2 (+ (length (car rect)) (length (cdr rect)))))
(define (area2 rect)

  (* (length (car rect)) (length (cdr rect))))

(define (acons x y)
  (lambda (f) (f x y)))

(define (acar c) (c (lambda (x y) x)))
(define (acdr c) (c (lambda (x y) y)))

(define (bcons x y)
  (* (expt 2 x) (expt 3 y)))

(define (bcar c)
  (define (car n c2)
    (if (= 0 (remainder c2 2))
        (car (+ n 1) (/ c2 2))
        n))
  (car 0 c))

(define (bcdr c)
  (define (cdr n c2)
    (if (= 0 (remainder c2 3))
        (cdr (+ n 1) (/ c2 3))
        n))
  (cdr 0 c))

(define zero (lambda (f) (lambda (x) x)))
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))

(define (add_one n) (lambda (f) (lambda (x) (f ((n f) x)))))

(define (addition n1 n2)
  (lambda (f) (lambda (x) ((n1 f) ((n2 f) x)))))

(define three (addition one two))

(define (inc x) ( + x 1))
(define zero_inc (zero inc))
(define (one_inc x) (((add_one zero) inc) x))

(define (make_interval a b) (cons a b))
(define low car)
(define high cdr)

(define (sub_interval in1 in2)
  (make_interval (- (low in2) (low in1)) (- (high in2) (high in1))))


(define (add_interval x y)
  (make_interval (+ ( low x) ( low y) )
  (+ (high x) (high y) )))


(define (mul_interval x y)
  (let ((p1 (* (low x) (low y)))
       (p2 (* (low x) (high y)))
       (p3 (* (high x) (low y)))
       (p4 (* (high x) (high y))))`
  (make_interval (min p1 p2 p3 p4)
                 (max p1 p2 p3 p4))))


(define (div_interval x y)
(if (<= 0 (* (low y) (high y))) 
       (error "Division error (interval spans 0)" y) 
       (mul_interval x  
                     (make-interval (/ 1. (high y)) 
                                    (/ 1. (low y))))))
(define (make_center_percent c p)
  (let ((cp (* c p)))
       (make_interval (- c cp) (+ c cp))
  )
)

(define (center in)
  (/ (+ (low in) (high in)) 2.0)
)

(define (tolerance in)
  (/ (- (high in) (center in)) (center in))
)

(define (last_pair l)
  (if (null? (cdr l))
    l
    (last_pair (cdr l))))


(define (reverse_list lis)
  (define (iter l acc)
    (if (null? (cdr l))
      (cons (car l) acc)
      (iter (cdr l) (cons (car l) acc))))
  (iter lis ()))

(define (deep_reverse l)
  (if (not (pair? l))
      l
      (reverse_list (map deep_reverse l))))

      

(define (count_coins amount coins)
  (cond ((= amount 0) 1)
	((or (< amount 0) (null? coins)) 0)
	(else (+ (count_coins (- amount (car coins)) coins)
	      (count_coins amount (cdr coins))))))
                            
(define (even_odd x) (remainder x 2))

(define (same_parity . x)
  (define (recur y)
    (cond ((null? y) y)
	  ((= (even_odd (car y)) (even_odd (car x)))
	   (cons (car y) (recur (cdr y))))
	  (else (recur (cdr y)))))
  (recur x))

(define (square x) (* x x))

(define (square_list1 l)
  (if (null? l)
      ()
      (cons (square (car l)) (square_list1 (cdr l)))))

(define (square_list2 l)
  (map square l))

(define (for_each f l)
  (if (not (null? l))
      (f (car l)))
  (if (null? l)
      0
      (for_each f (cdr l))))

(define (fringe l)
  (if (null? l)
      ()
      (if (pair? (car l))
	  (append (fringe (car l)) (fringe (cdr l)))
	  (cons (car l) (fringe (cdr l))))))

(define (make_mobile left right)
  (list left right))

(define (make_branch length structure)
  (list length structure))

(define left_branch car)

(define right_branch cadr)

(define branch_length car)

(define branch_structure cadr)

(define (total_weight mobile)
  (if (not (pair? mobile))
      mobile
      (+ (total_weight (branch_structure (left_branch mobile)))
	 (total_weight (branch_structure (right_branch mobile))))))

(define (branch_torque b) (* (branch_length b) (total_weight (branch_structure b))))

(define (is_mobile_balanced mobile)
  (if (not (pair? mobile))
      #t
      (let ((left (left_branch mobile))
            (right (right_branch mobile)))
           (if (= (* (branch_torque right))
	          (* (branch_torque left)))
	       (and (is_mobile_balanced (branch_structure right)) (is_mobile_balanced (branch_structure left)))
	       #f))))

; questions that help me with recursion; 1. how do I traverse, 2. what is the smallest unit I will reach by traversal       
(define (square_tree t)
  (cond ((null? t) ())
	((not (pair? t)) (square t))
	(else (cons (square_tree (car t)) (square_tree (cdr t))))))

; map provides what seems to be an iterative approach for tree recursion
; what I think the clever part about this is is that map does your traversal for you
(define (square_tree_map t)
  (cond ((null? t) ())
	((not (pair? t)) (square t))
	(else (map square_tree t))))

(define (tree_map f t)
  (define (iter t)
    (cond ((null? t) ())
	  ((not (pair? t)) (f t))
	  (else (map iter t))))
  (iter t))

; don't quite grok this
(define (subsets s) 
  (if (null? s) 
      (list ())   ;; initially had nil, always got () back! 
      (let ((rest (subsets (cdr s)))) 
           (append rest (map (lambda (x) (cons (car s) x)) rest)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
	   initial
	   (op (car sequence)
		   (accumulate op initial (cdr sequence)))))

(define (filter predicate sequence)
  (cond ((null? sequence) sequence)
		((predicate (car sequence))
		 (cons (car sequence)
			   (filter predicate (cdr sequence))))
		(else (filter predicate (cdr sequence)))))

(define (ex_map f sequence)
  (accumulate () (lambda (x y) (cons (f x) y)) sequence))

(define (ex_append seq1 seq2)
  (accumulate seq2 cons seq1))

(define (ex_length sequence)
  (accumulate 0 (lambda (x y) (+ 1 y)) sequence))


(define (horner_eval x coeff_sequence)
  (accumulate 0 (lambda (this_coeff higher_terms) (* x (+ this_coeff higher_terms)))
    coeff_sequence))

(define (count_leaves tree)
  (accumulate
	0
    +
	(map
	  (lambda (t)
		(cond
		  ((pair? t) (count_leaves t))
		  ((null? t) 0)
		  (else 1)))
	  tree)))

;uses maps to traverse each sequence in a seq of seqs simultaneosly
(define (accumulate_n op init seqs)
  (if (null? (car seqs))
	init
	(cons (accumulate op init (map car seqs))
		  (accumulate_n op init (map cdr seqs)))))

(define (dot_product v w)
  (accumulate + 0 (map * v w)))

(define (matrix_times_vector m v)
  (map (lambda (w) (accumulate 0 + (map * v w))) m))

(define (transpose m)
  (accumulate_n cons () m))

;dot product of each row in m by each column in n
(define (matrix_multiplication m n)
  (let ((cols (transpose n)))
	(map (lambda (row)
	  (matrix_times_vector cols row))
	m)))

(define (fold_left op init seq)
  (define (iter result rest)
	(if (null? rest)
	  result
	  (iter (op result (car rest)) (cdr rest))))
  (iter init seq))

(define (reverse_acc seq)
  (accumulate (lambda (x y) (append y (list x))) (list ()) seq))

(define (reverse_fl seq)
  (fold_left (lambda (x y) (cons y x)) () seq))

(define (tests)
  (define matrix (list (list 1 2 3 4) (list 5 6 7 8) (list 9 10 11 12)))
  (define vec (list 1 1 1 1))
  (print (transpose matrix)))
(tests)
