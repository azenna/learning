mod rectangle;
mod ip_address;
mod fibonacci_match;
mod linked_list;
mod hash_map;
mod error_handling;

fn main() {

    let s = error_handling::error_handling().expect("failed to read string");
    println!("{}", s);
}