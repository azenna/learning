mod lifetimes;

fn main() {
    let book = lifetimes::Book {title: "Where?", body: "lorum ipsum dolor"};
    println!("{}", book.length());
    
}