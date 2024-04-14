use std::io;

struct Set {
  parent: Vec<u32>,
  rank: Vec<u32>,
}

impl Set {
    fn default() -> Self {
      Self {
          parent: Vec::new(),
          rank: Vec::new(),
      }
    }
    fn make_set(&mut self){
        self.parent.push(self.parent.len() as u32);
        self.rank.push(0);
    }
    fn make_nset(n: usize) -> Self{
        Self {
            parent: (0..n).map(|x| x as u32).collect(),
            rank: (0..n).map(|_| 0).collect(),
        }
    }
    fn find(&self, n: u32) -> usize {
        self.parent
            .iter()
            .position(|x| *x == n)
            .unwrap()
    }
}

fn main() {

}
