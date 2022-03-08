use std::fs::File;
use std::io::{self, Read, ErrorKind};

pub fn error_handling() -> Result<String, io::Error>{
    
    
    // let my_file = File::open("my_file.txt").unwrap();

    // let my_file = match my_file {
    //     Ok(file) => file,
    //     Err(error) => match error.kind() {
    //         ErrorKind::NotFound => match File::create("my_file.txt") {
    //             Ok(fc) => fc,
    //             Err(error) => panic!("error creating the file!: {:?}", error)
    //         },
    //         other_error => {panic!("couldn't create file error: {:?}", other_error)},
    //     },
    // };
    
    //error propagation example
    // let file = File::open("hello.txt");

    // let mut file = match file {
    //     Ok(file) => file,
    //     Err(e) => return Err(e),
    // };

    // let mut s = String::new();

    // match file.read_to_string(&mut s){
    //     Ok(_) => Ok(s),
    //     Err(e) => Err(e),
    // }

    //error propagation using ? syntax rust.

    //first creating the file
    let mut file = File::open("hello.txt").unwrap_or_else(|error| {
        if error.kind() == ErrorKind::NotFound {
            //no semicolon file is returned
            File::create("hello.txt").expect("failed to create file")
        }
        else {
            panic!("failed to open file");
        }
    });

    let mut s = String::new();

    file.read_to_string(&mut s)?;
    Ok(s)
}