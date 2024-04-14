//not mine but I saw it somewhere and thought it was a really cool way to practice match
pub fn fibonacci(n: u32) -> u32{
    match n{
        
        1 | 2  => 1,
        3 => 2,
        _ => fibonacci(n-1) + fibonacci(n-2),
    }
}