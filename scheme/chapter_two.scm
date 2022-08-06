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
    (last_pair (cdr l))
  )
)

(define (reverse_list lis)
  (define (iter l acc)
    (print acc)
    (if (null? (cdr l))
      (cons (car l) acc)
      (iter (cdr l) (cons (car l) acc))
    )
  )
  (iter lis ())
)


(define (count_coins amount coins)
  (cond ((= amount 0) 1)
	((or (< amount 0) (null? coins)) 0)
	(else (+ (count_coins (- amount (car coins)) coins)
	      (count_coins amount (cdr coins))))))
                            
                  
(define (tests)
  (define us_coins (list 50 25 10 5 1))
  (define uk_coins (list 50 20 10 5 2 1 .5))
  (print (count_coins 100 uk_coins)))
(tests)



