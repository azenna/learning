use std::ops::Add;
use std::fmt;

#[derive(Debug, Copy, Clone, PartialEq)]
pub struct Point {
    pub x: i32,
    pub y: i32,
}

impl Add for Point {
    type Output = Point;

    fn add(self, other: Point) -> Point{
        Point {
            x: self.x + other.x,
            y: self.y + other.y
        }
    }
}

impl fmt::Display for Point{
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result{
        write!(f, "({}, {})", self.x, self.y)
    }
}

#[derive(Debug)]
pub struct Millimeters(pub u32);
pub struct Meters(pub u32);

impl Add<Meters> for Millimeters{
    type Output = Millimeters;

    fn add(self, other: Meters) -> Millimeters{
        Millimeters(self.0 + (other.0 * 1000))
    }
}

trait Pilot {
    fn fly(&self);
}

trait Wizard {
    fn fly(&self);
}

struct Human;

impl Human {
    fn fly(&self){
        println!("waves arms");
    }
}

impl Pilot for Human {
    fn fly(&self){
        println!("taking off!");
    }
}

impl Wizard for Human {
    fn fly(&self){
        println!("up");
    }
}

pub fn multiple_methods_with_same_names(){
    let person = Human;

    person.fly();

    //have to namespace from trait when method name is ambiguous;
    Pilot::fly(&person);
    Wizard::fly(&person);
}

trait Animal {
    fn baby_name();
}

struct Dog;

impl Dog {
    fn baby_name(){
        println!("a baby dog is called spot");
    }
}

impl Animal for Dog {
    fn baby_name(){
        println!("a baby dog is called a puppy");
    }
}

pub fn fully_qualified_syntax(){
    Dog::baby_name();
    <Dog as Animal>::baby_name();
}

trait OutlinePrint: fmt::Display{
    fn outline_print(&self){
        let output = self.to_string();
        let len = output.len();

        println!("{}", "*".repeat(len + 4));
        println!("*{}*", " ".repeat(len + 2));
        println!("* {} *", output);
        println!("*{}*", " ".repeat(len + 2));
        println!("{}", "*".repeat(len + 4))
    }
}

impl OutlinePrint for Point {}

pub fn outline_print_example(){
    let p = Point {x: 10, y: 20};
    p.outline_print();
}

//newtype pattern to get around orphan rule

struct Wrapper(Vec<String>);

impl fmt::Display for Wrapper{
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result{
        write!(f, "[{}]", self.0.join(", "))
    }
}

pub fn wrapper_ex(){
    let wrap = Wrapper(vec!["hello", "world"].into_iter().map(|s| s.to_string()).collect());
    println!("{}", wrap);
}