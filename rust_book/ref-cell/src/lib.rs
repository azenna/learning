#[cfg(test)]
mod tests {
    use super::*;
    use std::cell::RefCell;

    struct MockMessenger{
        sent_messages: RefCell<Vec<String>>,
    }

    impl MockMessenger{
        fn new() -> MockMessenger{
            MockMessenger {sent_messages: RefCell::new(Vec::new())}
        }
    }

    impl Messenger for MockMessenger{
        fn send(&self, message: &str){
            self.sent_messages.borrow_mut().push(message.to_string());
        }
    }

    #[test]
    fn percent_test_75(){
        let mock_messenger = MockMessenger::new();
        let mut limit_tracker = LimitTracker::new(&mock_messenger, 100);

        limit_tracker.set_value(75);

        assert_eq!(mock_messenger.sent_messages.borrow().len(), 1);
    }
}

pub trait Messenger {
    fn send(&self, message: &str);
}

pub struct LimitTracker<'a, T: Messenger>{
    messenger: &'a T,
    value: usize,
    max: usize,
}

impl<'a, T> LimitTracker<'a, T> where T: Messenger{
    pub fn new(messenger: &T, max: usize) -> LimitTracker<T>{
        LimitTracker {messenger, value: 0, max}
    }

    pub fn set_value(&mut self, value: usize){
        self.value = value;

        let percentage = self.value as f64 / self.max as f64;

        if percentage >= 1.0{
            self.messenger.send("Error: over quota");
        }
        else if percentage >= 0.9 {
            self.messenger.send("Urgent Warning: Used 90% of quota");
        }
        else if percentage >= 0.75 {
            self.messenger.send("Warning: Used 75% of quota");
        }
    }
}