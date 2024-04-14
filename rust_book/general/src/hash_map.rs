use std::collections::HashMap;
use rand::Rng;
use std::collections::hash_map::Entry::{Occupied, Vacant};


pub fn hash_maps(){
    

    let names: [&str; 5] = ["Zach", "John", "Ramwel", "Omar", "Malachi"];
    let wages = [10, 20, 30, 40, 50];

    let mut pay_roll: HashMap<&str, u32> = names.into_iter().zip(wages.into_iter()).collect();

    pay_roll.entry("Omarr").or_insert(60);

    

    for (name, wage) in pay_roll{
        println!("{} makes {}", name, wage);
    }

    let s = "And I think to myself what a wonderful world. At least I think it is";
    let mut map: HashMap<&str, u32> = HashMap::new();

    for word in s.split_whitespace(){
        map.entry(word).and_modify(|c| {*c += 1}).or_insert(1);
    }

    println!("{:?}", map);

    
}