mod oop;
use oop::*;

fn main() {
    let mut avg_col = AveragedCollection::new(vec![1, 2, 3, 4]);

    println!("{}", avg_col.average());

    avg_col.add(100);

    println!("{}", avg_col.average());
}
