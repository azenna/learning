#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        let result = 2 + 2;
        assert_eq!(result, 4);
    }
    #[test]
    fn it_work2() {
        let s = String::from("hello ") + "world";
        assert_eq!(s, "hello world".to_string());
    }
    // #[test]
    // fn borken() {
    //     assert_eq!(3, 4);
    // }

    #[test]
    fn rect_test(){
        let r1 = Rectangle (10, 20);
        let r2 = Rectangle (20, 40);

        assert!(r2.can_hold(&r1))
    }

    #[test]
    fn does_add_two(){
        assert_eq!(adds_two(10), 12);
    }

    #[test]
    #[ignore]
    fn greeting_message_works(){
        let greeting_message = greeting_message("Zach");
        assert!(greeting_message.contains("Zach"), "does not Zach, contained {}", greeting_message)
    }
    #[test]
    #[should_panic(expected="Guess must be between 1 and 100")]
    fn panic_on_new_guess(){
        Guess::new(0);
    }

    #[test]
    fn test_that_implements_result() -> Result<(), String>{
        let expression = 2 + 2;
        if expression == 4{
            Ok(())
        }
        else {
            Err(String::from("expression not equal four"))
        }
    }
}

struct Rectangle(u32, u32);

impl Rectangle {
    fn can_hold(&self, other: &Rectangle) -> bool{
        self.0 >= other.0 && self.1 >= other.1
    }
}

pub fn adds_two(num: u32) -> u32{
    num + 2
}

pub fn greeting_message(name: &str) -> String{
    format!("Hello {}", name)
}

pub struct Guess {
    pub guess: i32,
}

impl Guess {
    pub fn new(num: i32) -> Guess{
        if num < 1 || num > 100{
            panic!("Guess must be between 1 and 100");
        }
        Guess {guess: num}
    }
}