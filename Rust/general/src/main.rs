mod rectangle;
mod ip_address;
mod fibonacci_match;
mod linked_list;

fn main() {

    let mut head = linked_list::Node {data: 30, next: None};
    head.append(5);
    head.append(10);
    head.append(15);
    head.append(20);
    head.print_values();

}