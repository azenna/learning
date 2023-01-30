use smolgrep::Config;
use std::env;
use std::process;

fn main() {
    let config = Config::new(env::args()).unwrap_or_else(|error| {
        eprintln!("Problem processing arguments: {}", error);
        process::exit(1);
    });

    if let Err(error) = smolgrep::run(config) {
        eprintln!("Error: {}", error);
        process::exit(1);
    }
}
