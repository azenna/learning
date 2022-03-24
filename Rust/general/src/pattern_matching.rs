pub fn example(&(x, y): &(i32, i32)){
    println!("x is {}, y is {}", x, y);
}

pub fn fail_to_match(){
    //cannot fail_to_match only takes refutable patterns
    let x = 5;

    let y: Option<i32> = Some(52);

    //needs a refutable pattern, cannot match everything
    if let Some(z) = y{
        println!("{}", z);
    }
}

pub fn pattern_syntax(){

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
}