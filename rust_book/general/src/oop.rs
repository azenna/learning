pub struct AveragedCollection {
    values: Vec<i32>,
    average: f64,
}

impl AveragedCollection {
    pub fn new(values: Vec<i32>) -> AveragedCollection {
        let mut new_col = AveragedCollection {
            values,
            average: 0.0,
        };

        new_col.update_average();

        new_col
    }

    pub fn add(&mut self, val: i32) {
        self.values.push(val);
        self.update_average();
    }

    pub fn remove(&mut self) -> Option<i32> {
        let result = self.values.pop();

        match result {
            Some(value) => {
                self.update_average();
                Some(value)
            }
            None => None,
        }
    }

    pub fn average(&self) -> f64 {
        self.average
    }

    fn update_average(&mut self) {
        let total: i32 = self.values.iter().sum();

        self.average = total as f64 / self.values.len() as f64;
    }
}
