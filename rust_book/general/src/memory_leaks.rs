use std::cell::RefCell;
use std::rc::{Rc, Weak};

pub enum List {
    Cons(i32, RefCell<Rc<List>>),
    Nil
}

impl List {
    pub fn tail(&self) -> Option<&RefCell<Rc<List>>>{
        match self {
            List::Cons(_, item) => Some(item),
            List::Nil => None,
        }
    }
}

#[derive(Debug)]
pub struct Node {
    pub data: i32,
    pub children: RefCell<Vec<Rc<Node>>>,
    pub parent: RefCell<Weak<Node>>,
}