pub fn ten_main(){

    let p = Point {x: "hello", y: "hello"};

    println!("{}", p.concat());
}

//extract largest number functionality and put into a function
pub fn largest_num(list: &[i32]) -> i32{
    let mut largest: i32 = list[0];

    for num in list{
        if *num > largest{
            largest = *num;
        }
    }

    largest
}

struct Point<T, U>{
    x: T,
    y: U,
}

impl<T, U> Point<T, U>{
    fn contents(&self) -> (&T, &U){
        (&self.x, &self.y)
    }
}

impl Point<i32, i32>{
    fn multiply(&self) -> i32{
        self.x * self.y
    }
}

impl Point<&str, &str>{
    fn concat(&self) -> String{
        String::from(self.x) + self.y
    }
}