mod memory_leaks;
use memory_leaks::*;
use std::rc::{Rc, Weak};
use std::cell::RefCell;

fn main() {
    
    let leaf = Rc::new( Node {
        data: 10,
        children: RefCell::new(Vec::new()),
        parent: RefCell::new(Weak::new()),
    });

    let branch = Rc::new( Node{
        data: 5,
        children: RefCell::new(vec![Rc::clone(&leaf)]),
        parent: RefCell::new(Weak::new()),
    });

    *leaf.parent.borrow_mut() = Rc::downgrade(&branch);

    println!("leaf parent = {:?}", leaf.parent.borrow().upgrade());
}
