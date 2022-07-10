pub static mut COUNTER: i32 = 0;

pub fn dereferencing_a_raw_pointer(){
    let mut num = 5;
    let r1 = &num as *const i32;
    let r2 = &mut num as *mut i32;

    let address = 0x0123456usize;
    let r = address as *const i32;

    unsafe{
        println!("rl is: {}", *r1);
        println!("r2 is: {}", *r2);
    }

}

unsafe fn dangerous() {}

pub fn general(){

    //gots to call unsafe functions inside unsafe blocks
    unsafe {
        dangerous();
    }
}

extern "C"{
    fn abs(input: i32) -> i32;
}

pub fn calling_other_languages(){
    unsafe{

        println!("according to c the abs of -3 is {}", abs(-3));

    }
}

//a function callable from C
#[no_mangle]
pub extern "C" fn say_hi(){
    println!("hello there C!");
}

pub fn modifying_static_variable(){
    unsafe{
        COUNTER += 1;
    }
}

//an unsafe trait and implementation

unsafe trait Foo {}

unsafe impl Foo for i32 {}