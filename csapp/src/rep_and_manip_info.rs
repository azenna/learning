

pub fn least_sig_byte(a: usize) -> usize{
    a & 0xFF
}

pub fn all_but_lsb(a: usize) -> usize{
    a ^ ( !0x0 ^ 0xFF )
}

pub fn lsb_one(a: usize) -> usize{
    a | 0xFF
}

pub fn bis(a: usize, b: usize) -> usize{
    a | b
}

pub fn bic(a: usize, b: usize) -> usize{
    (a ^ b) & a
}

pub fn bit_or(a: usize, b: usize) -> usize{
    bis(a, b)
}

pub fn bit_xor(a: usize, b: usize) -> usize{
    
    bis(bic(a, b),
        bic(b, a))
}
