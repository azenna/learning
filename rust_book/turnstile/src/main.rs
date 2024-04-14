use crate::TurnStileState::*;
use crate::TurnStileOutput::*;

#[derive(Debug)]
enum TurnStileState {
    Locked,
    Unlocked
}

#[derive(Debug)]
enum TurnStileOutput {
    Open,
    Thank,
    Bloop
}

fn coin(s: TurnStileState) -> (TurnStileOutput, TurnStileState){
    (Thank, Unlocked)
}

fn push(s: TurnStileState) -> (TurnStileOutput, TurnStileState){
    match s {
        Locked => (Bloop, Locked),
        Unlocked => (Open, Locked)
    }
}


fn ts_bind<F, G, H>(f: F, g: H) ->
    impl Fn(TurnStileState) -> (TurnStileOutput, TurnStileState)
    where F: Fn(TurnStileState) -> (TurnStileOutput, TurnStileState),
          G: Fn(TurnStileState) -> (TurnStileOutput, TurnStileState),
          H: Fn(TurnStileOutput) -> G{

    move |s| {
        let (o, ns) = f(s);
        (g(o))(ns)
    }
}

fn main() {
  let x = ts_bind(coin, |_| ts_bind(push, |_| push));

  println!("{:?}", x(Locked));
}
