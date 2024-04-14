package main

import (
	"fmt"
	"math/rand"
	"math"
	"runtime"
	"time"
	"golang.org/x/tour/pic"
	"strings"
	"io"
	"golang.org/x/tour/reader"
	"os"
	"golang.org/x/tour/tree"
	"sync"
)

func add_points(x, y Point) Point {
	return Point{x.X + y.X, x.Y + y.Y}
}

func add (x int, y int) int {
	return x + y
}

func add_three(x, y, z int) int {
	return x + y + z
}

func swap (x, y string) (string, string) {
	return y, x
}

func div_rem(x, y int) (quo, rem int){
	quo = x / y
	rem = x % y
	return
}

func sum_of_squares(x uint) uint {
	var sum uint = 0
	for i := 0; uint(i) <= x; i++ {
		sum += uint(i * i)
	}
	return sum
}

func fib_string(x uint) string{
	if x == 0  || x == 1 || x == 2 {
		return fmt.Sprint(x / x)
	} else {
		return fmt.Sprint(x, fib_string(x - 1), fib_string(x - 2)) 
	}
}

func sqrt_root(x float64) (float64, error){
	if x < 0.0 {
		return 0, &MyError{time.Now(), "imaginary root"}
	}
	z := 1.0
	change := 100.0

	for math.Abs(change) > 0.001 {
		change = (z*z - x) / (2*z)
		z -= change
	}

	return z, nil
}

func defers() {
	defer fmt.Println("world")

	fmt.Println("hello")
}

func launch() {

	defer fmt.Println("Lift Off!!!")

	for i := 0; i < 10; i++{
		defer fmt.Println(i)
	}


	fmt.Println("T-...")
}

func pows(n uint) []uint{
	if n <= 1{
		return []uint{1}
	}
	return append(pows(n - 1), n * n)
}

func Pic(dx, dy int) [][]uint8 {
	y := make([][]uint8, dy)
	for i, _ := range y{
		y[i] = make([]uint8, dx)
		for j, _ := range y[i]{
			y[i][j] = uint8(i * j)
		}
	}
	return y
}

func count_words(s string) map[string]uint{
	m := make(map[string]uint)

	for _, v := range strings.Fields(s) {
		m[v] += 1
	}
	return m
}

func compute(fn func(float64, float64) float64) float64 {
	return fn(1.0, 2.0)
}

func closure_test() func(int) int{
	sum := 0
	return func(x int) int {
		sum += x
		return sum
	}
}

func fibonacci() func() uint{
	fib, fib2 := 0, 1
	return func() uint{
		a := fib
		fib = fib2
		fib2 += a
		return uint(a)
	}
}

var a1, b1, c1, d1 string

var zz, yy int = 38, 23

const Pi = 3.141592653589

const (
	Big = 1 << 50
	Small = Big >> 49
)

func mainold() {
	fmt.Println("Hello World!")
	fmt.Println("My favorit number is", rand.Intn(10))
	fmt.Println(math.Pi)
	
	seven := add(3, 4)
	fmt.Println(seven)

	fmt.Println(add_three(1,2,3))

	a, b := swap("hello", "world")

	fmt.Println(a, b)

	quo, rem := div_rem(93, 7)
	fmt.Println(quo, rem)

	fmt.Println(a1, b1, c1, d1)
	fmt.Println(yy, zz)

	var eight int = 8
	var eight_f float32 = float32(eight)
	fmt.Println(eight_f)

	fmt.Println(Big, Small)
	fmt.Println(sum_of_squares(3))

	sum := sum_of_squares(3)

	for ; sum < 1000;{
		sum *= sum
		fmt.Println(sum)
	}

	for sum > 1 {
		sum /= (sum)
		fmt.Println(sum)
	}

	for {
		//loops forever
		break
	}

	fmt.Println(fib_string(10))
	
	if l := len(fib_string(10)); l < 10 {
		fmt.Println("Wow!")
	} else {
		fmt.Println("Not Wow!", l)
	}

	fmt.Println(sqrt_root(25.0))

	switch os := runtime.GOOS; os {
	case "darwin":
		fmt.Println("OS X")
	case "linux":
		fmt.Println("Linux.")
	default:
		fmt.Printf("%s.\n", os)
	}


	switch t := time.Now(); {
	case t.Hour() < 12:
		fmt.Println("Good Morning!")
	case t.Hour() < 17:
		fmt.Println("Good afternoon.")
	default:
		fmt.Println("Good evening.")
	}

	defers()

	launch()

	var p_sum *uint = &sum
	fmt.Println(*p_sum)

	p1 := Point{3, 4}
	p2 := Point{2, 7}

	pp1 := &p1

	fmt.Println(pp1.X)

	fmt.Println(add_points(p1, p2))

	list := &Node{3, &Node{2, &Node{4, nil}}}

	print_nodes(list)

	new_nodes := reverse_nodes(list, nil)

	print_nodes(new_nodes)

	sts := [2]string{"hello", "world"}

	fmt.Println(sts)

	primes := [6]int{2, 3, 5, 7, 11, 13}

	first_four := primes[0:3]

	first_four[2] = 18

	fmt.Println(first_four)
	fmt.Println(primes)


	var slice_lit []bool = []bool{true, true, false}
	fmt.Println(slice_lit)

	first_five := first_four[:5]
	fmt.Println(first_five)

	fmt.Println(cap(first_five), len(first_five))

	var nil_slice []int

	fmt.Println(nil_slice)

	slc := make([]int, 5, 100)
	fmt.Println(slc[0:10])

	first_four_seven := append(first_four, 7)

	fmt.Println(first_four_seven)
	fmt.Println(primes)

	for _, v := range pows(10){
		fmt.Println(v)
	}

	pic.Show(Pic)

	var locations map[string]Point
	locations = make(map[string]Point)

	locations["Texas"] = Point{0, 0}
	fmt.Println(locations["Texas"])

	var location2 = map[string]Point{
		"Texas": Point{0, 0},
		"Idaho": Point{1, 1},
	}

	if elem, ok := location2["Texas"]; ok {
		fmt.Println(elem)
		delete(location2, "Idaho")
	}

	fmt.Println(location2)
	fmt.Println(count_words("hey there hey hows it going"))

	times_minus := func(x, y float64) float64 {
		return x * y - y
	}

	fmt.Println(compute(times_minus))

	pos, neg := closure_test(), closure_test()

	ab := pos(5)
	neg(-2)
	bb := neg(-7)

	fmt.Println(ab, bb)

	fib := fibonacci()

	fmt.Println(fib(), fib(), fib(), fib(), fib())

	var pN Norm = &Point{5, 6}
	var pN2 Norm = &Point3D{5, 6, 7}

	
	list.Map(curried_add(7))
	list.Print()

	fmt.Println(pN.Norm(), pN2.Norm())
	fmt.Println(twice_norm(pN))

	p2d, ok := pN.(*Point)
	fmt.Println(p2d, ok)

	p2d2, ok := pN2.(*Point)
	fmt.Println(p2d2, ok)

	switch o := pN2.(type) {
	case *Point:
		fmt.Println(o.Y)
	case *Point3D:
		fmt.Println(o.Z)
	default:
		break
	}

	fmt.Println(list)

	hosts := map[string]IpAddr{
		"home": {127, 0, 0, 1},
		"googleDNS": {8, 8, 8, 8},
	}

	for name, ip := range hosts{
		fmt.Printf("%v: %v\n", name, ip)
	}

	if err := run(); err != nil {
		fmt.Println(err)
	}

	fmt.Println(sqrt_root(-2.0))

	r := strings.NewReader("Hello Reader!")

	b2 := make([]byte, 8)
	for {
		n, err := r.Read(b2)
		fmt.Printf("n = %v err = %v b = %v\n", n, err, b2)
		fmt.Printf("b[:n] = %q\n", b2[:n])
		if err == io.EOF{
			break
		}
	}

	reader.Validate(MyReader{})

	rot13Reader{MyReader{}}.Read(b2)

	fmt.Println(b2, len(b2))

	s1 := strings.NewReader("Lbh penpxrq gur pbqr!")
	r1 := rot13Reader{s1}
	io.Copy(os.Stdout, &r1)

	head := make_ll(3, make_ll(4, make_ll(5, nil)))

	daeh := Reverse(head)

	fmt.Println(head, daeh)
}

type Point3D struct {
	X, Y, Z int
}

type Norm interface {
	Norm() float64
}

func (p *Point3D) Norm() float64 {
	return math.Sqrt(float64(p.X * p.X + 
			  p.Y * p.Y +
		      p.Z * p.Z))
}

func (p *Point) Norm() float64 {
	return math.Sqrt(float64(p.X * p.X +
			  p.Y * p.Y))
}


func twice_norm(n Norm) float64{
	return 2.0 * n.Norm()
}

type Point struct {
	X int
	Y int
}

func (v Point) add(u Point) Point {
	return Point {v.X + u.X, v.Y + u.Y}
}

type Node struct {
	Data int
	Next *Node
}

func (head *Node) String() string {
	if head.Next == nil{
		return fmt.Sprint(head.Data)
	}
	return fmt.Sprint(fmt.Sprint(head.Data), ",", head.Next.String())
}

func (head *Node) Print() {
	fmt.Println(head.Data)
	if head.Next == nil{
		return
	}
	head.Next.Print()
}

func (head *Node) Map(fn func(int) int) {
	head.Data = fn(head.Data)
	if head.Next == nil{
		return
	}
	head.Next.Map(fn)
}

func curried_add(x int) func(int) int{
	return func(y int) int{
		return x + y
	}
}

func print_nodes(head *Node){
	fmt.Println(head)
	if head.Next == nil{
		return
	}
	print_nodes(head.Next)
}

func reverse_nodes(head, acc *Node) *Node{

	if head.Next == nil{
		return &Node{head.Data, acc}
	}

	return reverse_nodes(head.Next, &Node{head.Data, acc})
}

type Data interface {
	int | int64 | string | uint
}

type NodeGeneric[T Data] struct {
	Data T
	Next *NodeGeneric[T]
}

type IpAddr [4]byte

func (ip IpAddr) String() string{
	return fmt.Sprint(
		ip[0],
		".",
		ip[1],
		".",
		ip[2],
		".",
		ip[3],
	)
}

type MyError struct {
	When time.Time
	What string
}

func (e *MyError) Error() string {
	return fmt.Sprintf("at %v, %s", e.When, e.What)
}

func run() error {
	return &MyError{
		time.Now(),
		"it didn't work",
	}
}

type MyReader struct {}

func (r MyReader) Read(buf []byte) (int, error){
	for i, _ := range buf{
		buf[i] = 'A'
	}
	return len(buf), nil
}

type rot13Reader struct {
	r io.Reader
}

func (r13r rot13Reader) Read(buf []byte) (int, error){
	x, err := r13r.r.Read(buf)
	if err == nil{
		for i, _ := range buf{
			pv := &buf[i]
			switch {
			case *pv >= 'A' && *pv <= 'Z':
				*pv = 'A' + (*pv-'A'+13)%26
			case  *pv >= 'a' && *pv <= 'z':
				*pv = 'a' + (*pv-'a'+13)%26
			}
		}
	}
	return x, err
}

type LinkedList[T any] struct {
	val T
	next *LinkedList[T]
}

func (head *LinkedList[T]) String() string {
	if head.next == nil {
		return fmt.Sprint(head.val)
	}

	return fmt.Sprint(head.val, ",", head.next.String())
}

func make_ll[T any](t T, next *LinkedList[T]) *LinkedList[T]{
	return &LinkedList[T]{
		val: t,
		next: next,
	}
}

func Reverse[T any](head *LinkedList[T]) *LinkedList[T]{
	return reverse(head, nil)
}

func reverse[T any](head, acc *LinkedList[T]) *LinkedList[T] {
	if head.next == nil{
		return make_ll(head.val, acc)
	}
	return reverse(head.next, make_ll(head.val, acc))
}

func sum(s []int, c chan int) {
	sum := 0
	for _, v := range s {
		sum += v
	}
	c <- sum
}

func mainold2(){
	s := []int{1, 2, 3, 4, 5, 6}
	c := make(chan int)
	go sum(s[:len(s)/2], c)
	go sum(s[len(s)/2:], c)
	x, y := <- c, <- c

	fmt.Println(x, y, x + y)

	ch := make(chan int, 2)
	ch <- 1
	ch <- 2
	fmt.Println(<- ch)
	fmt.Println(<- ch)
	ch <- 3
	fmt.Println(<- ch)

	c2 := make(chan int, 10)
	// go fibonacci2(100, c2)

	quit := make(chan int)

	go func() {
		for i := 0; i < 10; i++ {
			fmt.Println(<- c2)
		}
		quit <- 0
	}()

	fib3(c2, quit)

	// for v := range c2{
	// 	fmt.Println(v)
	// }

	// tick := time.Tick(100 * time.Millisecond)
	// boom := time.After(500 * time.Millisecond)
	//
	// for {
	// 	select {
	// 	case <- tick:
	// 		fmt.Println("tick.")
	// 	case <- boom:
	// 		fmt.Println("Boom!!!")
	// 	default:
	// 		fmt.Println("      .")
	// 		time.Sleep(50 * time.Millisecond)
	// 	}
	// }
	
	// c3 := make(chan int, 10)
	// go Walk(tree.New(1), c3)
	//
	// for i := 0; i < 10; i++ {
	// 	fmt.Println(<- c3)
	// }

	fmt.Println(Same(tree.New(2), tree.New(2)))
}

func fibonacci2(n int, c chan int) {
	x, y := 0, 1
	for i := 0; i < n; i++{
		c <- x
		x, y = y, x + y
	}
	close(c)
}

func fib3(c, quit chan int) {
	x, y := 0, 1
	for {
		select {
		case c <- x:
			x, y = y, x + y
		case <- quit:
			fmt.Println("Quitting fib3")
			return
		}
	}
}

func Walk(t *tree.Tree, ch chan int) {
	walk(t, ch)
	close(ch)
}

func walk(t *tree.Tree, ch chan int) {
	if t == nil {
		return
	}
	walk(t.Left, ch)
	ch <- t.Value
	walk(t.Right, ch)
}

func Same(t *tree.Tree, t2 *tree.Tree) bool {
	c1 := make(chan int)
	c2 := make(chan int)

	go Walk(t, c1)
	go Walk(t2, c2)

	acc := true

	for {
		a, oka := <- c1
		b, okb := <- c2

		acc = acc && a == b
		
		if !(oka && okb){
			return acc
		}
	}
}

func main(){
	c := SafeCounter{v: make(map[string]int)}
	for i := 0; i < 1000; i++ {
		go c.Inc("somekey")
	}
	time.Sleep(time.Second)
	fmt.Println(c.Value("somekey"))
}

type SafeCounter struct {
	mu sync.Mutex
	v map[string]int
}

func (c *SafeCounter) Inc(key string){
	c.mu.Lock()
	c.v[key]++
	c.mu.Unlock()
}

func (c *SafeCounter) Value(key string) int{
	c.mu.Lock()
	defer c.mu.Unlock()
	return c.v[key]
}
