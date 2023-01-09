use std::ops::Deref;
use std::rc::Rc;

pub enum List{
    Cons(i32, Rc<List>),
    Nil,
}

impl List {
    pub fn print(&self){
        match self {
            List::Cons(val, next) => {
                println!("{}", val);
                next.print();
            }
            List::Nil => return,
        }
    }
}

pub struct MyBox<T>(T);

impl<T> MyBox<T>{
    pub fn new(val: T) -> MyBox<T>{
        MyBox(val)
    }
}

impl<T> Deref for MyBox<T>{
    type Target = T;

    fn deref(&self) -> &Self::Target{
        &self.0
    }
}

pub fn hello(name: &str){
    println!("Hello, {}", name);
}

pub struct CustomSmartPointer {
    pub data: String,
}

impl Drop for CustomSmartPointer {
    fn drop(&mut self){
        println!("Dropping CustomSmartPointer with data, {}", self.data);
    }
}