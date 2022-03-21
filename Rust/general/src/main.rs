mod smart_pointers;
use smart_pointers::List::*;
use std::rc::Rc;

fn main() {
    
    let list_a = Rc::new(Cons(1, Rc::new(Cons(1, Rc::new(Cons(1, Rc::new(Cons(1, Rc::new(Nil)))))))));
    let list_b = Cons(2, Rc::clone(&list_a));
    {
        let list_c = Cons(3, Rc::clone(&list_a));
        println!("Rc count a: {}", Rc::strong_count(&list_a));
    }
    println!("Rc count a: {}", Rc::strong_count(&list_a));
}
