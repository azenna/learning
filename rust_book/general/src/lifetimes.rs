
pub fn longest_string<'a>(s1: &'a str, s2: &'a str) -> &'a str{
    if s1.len() > s2.len() {s1} else {s2}
}

pub struct Book<'a>{
    pub title: &'a str,
    pub body: &'a str,
}

impl<'a> Book<'a>{
    pub fn length(&self) -> usize{
        self.body.len()
    }
}

//cool function from the book demonstrating everything chapter 10.
// fn longest_with_an_announcement<'a, T>(
//     x: &'a str,
//     y: &'a str,
//     ann: T,
// ) -> &'a str
// where
//     T: Display,
// {
//     println!("Announcement! {}", ann);
//     if x.len() > y.len() {
//         x
//     } else {
//         y
//     }
// }