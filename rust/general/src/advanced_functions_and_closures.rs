fn three_times_plus_one(x: i32) -> i32 {
    x * 2 + 1
}

fn divide_two(x: i32) -> i32 {
    x / 2
}

fn perform_operation(f: fn(i32) -> i32, num: i32) -> i32 {
    f(num)
}

pub fn syracuse_problem(mut x: i32) -> i32 {
    let mut steps = 0;

    while x != 1 {
        if x % 2 != 0 {
            x = perform_operation(three_times_plus_one, x);
        } else {
            x = perform_operation(divide_two, x);
        }
        println!("{}", x);
        steps += 1;
    }

    steps
}

enum Status {
    Value(i32),
    Stop,
}

pub fn function_pointers_with_map() {
    let v = vec!["hello", "world", "how", "are", "you", "today"];

    let v: Vec<String> = v.into_iter().map(String::from).collect();

    //passes values to tuple initializer
    let status_list: Vec<Status> = (0..32).map(Status::Value).collect();
}

pub fn returns_a_closure() -> Box<dyn Fn(i32) -> i32> {
    Box::new(|x| x + 1)
}
