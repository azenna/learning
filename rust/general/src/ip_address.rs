#[derive(Debug)]
pub enum IpAddress {
    ipv4(String),
    ipv6(String),
}

impl IpAddress {
    pub fn print_type(&self){
        match self {
            IpAddress::ipv4(address) => println!("ipv4: {}", address),
            IpAddress::ipv6(address) => println!("ipv6: {}", address),
        }
    }
}