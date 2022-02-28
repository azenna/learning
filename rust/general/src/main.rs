fn main() {
    let person = init_person("zach", 16);

    let mut rect = Rectangle::new(10, 10);
    rect.scale(10);

    println!("{:?} has an area of {}", rect, rect.area());
}


fn half_of_string(s: &String) -> &str{
    &s[0..s.len()/2]
}

struct Person {
    name: String,
    age: u64,
}

fn init_person(name: &str, age: u64) -> Person{
    Person{name: String::from(name), age: age,}
}

#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn new(width: u32, height: u32) -> Rectangle{
        Rectangle {width, height}
    }
    fn area(&self) -> u32{
        self.width * self.height
    }
    fn scale(&mut self, scalar: u32){
        self.width *= scalar;
        self.height *= scalar;
    }
}
