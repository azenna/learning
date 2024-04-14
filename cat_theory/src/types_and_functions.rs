use std::collections::HashMap;
use core::hash::Hash;

pub struct Memoized<F, A, B>(F, Box<HashMap<A, B>>);

impl<F, A, B> Memoized<F, A, B>
where
    F: Fn(A) -> B,
    A: Eq + Hash + Clone,
{

    fn new(f: F) -> Self{
        Memoized(f, Box::new(HashMap::new()))
    }

    fn call<'a>(mut self, a: A) -> (&'a B, Self) where Self: 'a{

        let val: *const B = self.1.entry(a.clone()).or_insert((self.0)(a));

        (unsafe { &*val }, self)
        
    }

    fn multiple<'a>(mut self, v_as: Vec<A>) -> (Vec<&'a B>, Self) where Self: 'a{
        v_as.into_iter().fold((vec![], self), |acc, next| {

            let (mut vec, s) = acc;
            
            let (val, s) = s.call(next);

            vec.push(val);

            (vec, s)
            
        })
    }
}

