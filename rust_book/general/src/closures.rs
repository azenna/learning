use std::collections::HashMap;
use std::thread;
use std::time::Duration;

pub fn generate_workout(intensity: u32, random_number: u32) {
    let mut cached = Cacher::new(|num| {
        println!("Calculating slowly...");
        thread::sleep(Duration::from_secs(2));
        num
    });

    //low intensity workout
    if intensity < 25 {
        println!("do {} situps", cached.value(intensity));
        println!("and do {} pushups", cached.value(intensity * 2));
        println!("lastly do {} squats", cached.value(intensity));
    } else {
        if random_number == 3 {
            println!("Take a break today!");
        } else {
            println!("Run for {} minutes", cached.value(intensity));
        }
    }
}

//a slow function that takes time
pub fn takes_time(intensity: u32) -> u32 {
    println!("Calculating slowly...");

    thread::sleep(Duration::from_secs(2));
    intensity
}

//never seen this code writing pattern before, but it is pretty interesting.
struct Cacher<T: Fn(u32) -> u32> {
    calculation: T,
    dict: HashMap<u32, u32>,
}

impl<T> Cacher<T>
where
    T: Fn(u32) -> u32,
{
    fn new(calculation: T) -> Cacher<T> {
        Cacher {
            calculation,
            dict: HashMap::new(),
        }
    }

    fn value(&mut self, value: u32) -> u32 {
        match self.dict.get(&value) {
            Some(val) => *val,
            None => {
                let val = (self.calculation)(value);
                self.dict.insert(value, val);
                val
            }
        }
    }
}

pub fn capture_environment_example() {
    let x = 4;

    let eq_x = |z| z == x;

    let y = 4;

    assert!(eq_x(y));

    let x = vec![1, 2, 3];

    let eq_x = move |z| z == x;

    // println!("this causes an error {:?}", x);

    let y = vec![1, 2, 3];

    assert!(eq_x(y))
}
