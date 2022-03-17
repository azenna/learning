pub fn iterators_main() {
    let vec1 = vec![1, 2, 3];

    let vec1_iter = vec1.iter();

    let total: i32 = vec1_iter.sum();

    assert_eq!(total, 6);

    let v1: Vec<u32> = vec![1, 2, 3, 4];

    let v1_map: Vec<_> = v1.iter().map(|x| x * x).collect();

    for item in v1_map {
        println!("{}", item);
    }

    let mut str_vec: Vec<&str> = vec![
        "hello",
        "hello there",
        "what's up",
        "how are you doing today",
        "have I already said hello?",
    ];

    str_vec = str_vec
        .into_iter()
        .filter(|s| !(s.contains("hell")))
        .collect();

    for s in str_vec {
        println!("{}", s);
    }
}

pub struct Counter {
    count: u32,
}

impl Counter {
    pub fn new() -> Counter {
        Counter { count: 0 }
    }
}

impl Iterator for Counter {
    type Item = u32;

    fn next(&mut self) -> Option<Self::Item> {
        if self.count < 5 {
            self.count += 1;
            Some(self.count)
        } else {
            None
        }
    }
}
