use std::io;
use std::io::Write;

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        let button = Button {
            height: 5,
            width: 10,
            label: String::from("hello button"),
        };

        let screen = Screen {
            components: vec![Box::new(button)],
        };

        screen.run();
    }
}

pub trait Draw {
    fn draw(&self);
}

pub struct Screen {
    pub components: Vec<Box<dyn Draw>>,
}

impl Screen {
    pub fn run(&self) {
        for comp in self.components.iter() {
            comp.draw();
        }
    }
}

pub struct Button {
    pub height: u32,
    pub width: u32,
    pub label: String,
}

impl Draw for Button {
    fn draw(&self) {
        let button: Vec<Vec<char>> = (0..self.height)
            .map(|y| {
                (0..self.width)
                    .map(|x| {
                        if y == 0 || y == self.height - 1 {
                            '-'
                        } else if x == 0 || x == self.width - 1 {
                            '|'
                        } else {
                            ' '
                        }
                    })
                    .collect()
            })
            .collect();

        println!("{}:", self.label);

        for row in button {
            for j in row {
                print!("{}", j);
            }
            print!("\n");
        }
    }
}
