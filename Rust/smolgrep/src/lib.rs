use std::env;
use std::error::Error;
use std::fs;

pub fn run(config: Config) -> Result<(), Box<dyn Error>> {
    let files = find_sub_files(config.path)?;

    for file in files {
        let file_contents = match fs::read_to_string(&file) {
            Ok(contents) => contents,
            _ => continue,
        };

        for line in search(&config.query, &file_contents) {
            println!("in file {} {}", file, line);
        }
    }

    Ok(())
}

//I feel like a genius rn it actually works. something I wrote myself in rust actually works!!!

pub fn find_sub_files(path: String) -> Result<Vec<String>, Box<dyn Error>> {
    //two vectors, one to keep track of all of the file paths one to hold the directories we need to iterate over
    let mut file_paths: Vec<String> = Vec::new();
    let mut dirs: Vec<String> = Vec::new();

    //catches a path that is just a file and returns a vector containing it alone
    if fs::metadata(&path)?.is_file() {
        return Ok(vec![path]);
    }

    //if it doesn't return above read the path as a dir;
    for path in fs::read_dir(path)? {
        //take the dirEntry object that is path and get a coherent path string out of it
        let path_str = path?.path().as_path().display().to_string();

        //if the path string is a file, push it to path strings otherwise add it to list of directories vector
        if fs::metadata(&path_str)?.is_file() {
            file_paths.push(path_str);
        } else {
            dirs.push(path_str);
        }
    }

    //iterate through dirs and recurse, appending their returned path list vectors to the parents.
    for path in dirs {
        let mut sub_files = find_sub_files(path)?;
        file_paths.append(&mut sub_files);
    }

    //return result
    Ok(file_paths)
}

pub fn search<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
    contents
        .lines()
        .filter(|line| line.contains(query))
        .collect()
}

pub struct Config {
    pub query: String,
    pub path: String,
}

impl Config {
    pub fn new(mut args: env::Args) -> Result<Config, &'static str> {
        args.next();

        let query = match args.next() {
            Some(q) => q,
            None => return Err("No query found"),
        };

        let path = match args.next() {
            Some(p) => p,
            None => return Err("No path found"),
        };

        Ok(Config { query, path })
    }
}
