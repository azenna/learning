use std::thread;
use std::sync::mpsc;
use std::time::Duration;

fn main() {
    
    let (tx, rx) = mpsc::channel();

    let tx1 = tx.clone();

    thread::spawn(move || {
        tx.send("hello there").unwrap();
    });

    thread::spawn(move || {
        tx1.send("how are you today").unwrap();
    });

    for rec in rx{
        println!("got: {}", rec);
    }

}
