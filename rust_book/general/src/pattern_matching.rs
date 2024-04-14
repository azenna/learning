use std::iter::Iterator;

pub fn example(&(x, y): &(i32, i32)) {
    println!("x is {}, y is {}", x, y);
}

pub fn fail_to_match() {
    //cannot fail_to_match only takes refutable patterns
    let x = 5;

    let y: Option<i32> = Some(52);

    //needs a refutable pattern, cannot match everything
    if let Some(z) = y {
        println!("{}", z);
    }
}

pub fn pattern_syntax() {
    //matching literals
    let x = 1;

    match x {
        1 => println!("one"),
        2 => println!("two"),
        3 => println!("three"),
        4 => println!("four"),
        5 => println!("five"),
        _ => println!("haven't learned to count that high yet"),
    }

    //multiple patterns
    match x {
        1 | 2 => println!("one or two"),
        _ => println!("other"),
    }

    //matching ranges
    match x {
        0..=5 => println!("in between 0 and 5"),
        _ => println!("not between 0 and 5"),
    }

    //also match char ranges
    let y = 'c';

    match y {
        'a'..='c' => println!("first three chars"),
        _ => println!("last 23 chars"),
    }

    let p = Point { x: 0, y: 10 };

    match p {
        Point { x: 0, y } => println!("on y axis"),
        Point { x, y: 0 } => println!("on x axis"),
        Point { x, y } => println!("on neither axis"),
    }

    let msg = Message::ChangeColor(Color::Hex(String::from("0xFFFFFF")));

    match msg {
        Message::Quit => println!("quit"),
        Message::Move { x, y } => println!("moved to {}, {}", x, y),
        Message::Write(m) => println!("holds message {}", m),
        Message::ChangeColor(Color::Rgb(r, g, b)) => {
            println!("color changed to rgb values {}, {}, {}", r, g, b)
        }
        Message::ChangeColor(Color::Hex(hx)) => println!("color changed to hex value {}", hx),
    }

    //crazy destructuring example
    let ((a, b), Point { x, y }) = ((10, 20), Point { x: 30, y: 40 });

    //use underscores to ignore pattern matches
    for _ in a..=y {
        println!("no value to print because we ignored it");
    }

    // I really want to turn a range into a tuple here but I can't for the life of me figure out how
    let numbers = (1, 2, 3, 4, 5);
    let (_first, _second, _third, _, _) = numbers;

    //only using part of struct and ignoring all remaining values
    let Point3D { x, .. } = Point3D {
        x: 10,
        y: 20,
        z: 30,
    };

    match numbers {
        (first, _, second, ..) => println!("first: {}, second: {}", first, second),
    }

    //match guard example
    let num = Some(5);

    match num {
        Some(x) if x < 5 => println!("num is less than 5"),
        Some(_) => println!("x is not less than 5"),
        None => (),
    }

    //or used in conjunction with match guad
    let x = 4;
    let y = false;

    match x {
        4 | 5 | 6 if y => println!("yes"),
        _ => println!("no"),
    }

    //in order to bind and test use an @ operator

    let a = Some(10);

    match a {
        Some(val @ 9..=11) => println!("value: {} is in range 9 to 11", val),
        Some(12..=13) => {
            println!(" the value is in between 12 and 13, but we don't know what it is")
        }
        _ => (),
    }
}

struct Point {
    x: i32,
    y: i32,
}

struct Point3D {
    x: i32,
    y: i32,
    z: i32,
}

enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(Color),
}

enum Color {
    Rgb(i32, i32, i32),
    Hex(String),
}
