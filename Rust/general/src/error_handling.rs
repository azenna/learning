use std::fs::File;
use std::io::ErrorKind;

pub fn error_handling(error_message: &str){
    
    
    let my_file = File::open("my_file.txt");

    let my_file = match my_file {
        Ok(file) => file,
        Err(error) => match error.kind() {
            ErrorKind::NotFound => match File::create("my_file.txt") {
                Ok(fc) => fc,
                Err(error) => panic!("error creating the file!: {:?}", error)
            },
            other_error => {panic!("couldn't create file error: {:?}", other_error)},
        },
    };
}