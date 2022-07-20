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
  (l))

(define (tests)
  (define rect1 (rectangle (make_point 1 1) (make_point 5 5)))
  (print (perimeter rect1))
  (print (perimeter rect1))
  (define rect2 (make_rect2 (make_line (make_point 1 1) (make_point 1 5)) (make_line (make_point 1 1) (make_point 5 1))))
  (print (perimeter2 rect2))
  (print (area2 rect2)))
  (define my_cons (acons 5 6))
  (print (acar my_cons))

(tests)



