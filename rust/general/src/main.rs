fn main() {

    let mut rect = Rectangle::new(10, 10);
    rect.scale(10);

    println!("{:?} has an area of {}", rect, rect.area());
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
