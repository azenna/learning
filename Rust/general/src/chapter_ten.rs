pub fn ten_main(){

    let vid = Video {creator: String::from("john"),
                        video: String::from("a;lsdjk;f;kasdfk;"),
                        description: String::from("programming video"),
                        title: String::from("I learn rust")
                    };

    let news_art = NewsArticle {
        headline: String::from("fire while learning rust!"),
        body: String::from("there was a fire while john was learning rust in the school library"),
        author: String::from("john"),
        date: String::from("3/9/22"),
    };


    push_notification(&vid);
    push_notification(&news_art);

    let vec = vec![19.1, 20.2, 30.3];
    println!("{}", largest_num(&vec));
    
}

//extract largest number functionality and put into a function
//yay it's generic now
pub fn largest_num<T: std::cmp::PartialOrd>(list: &[T]) -> &T{
    let mut largest = &list[0];

    for num in list{
        if num > largest{
            largest = num;
        }
    }

    largest
}

struct Point<T>{
    x: T,
    y: T,
}

impl<T> Point<T>{
    fn contents(&self) -> (&T, &T){
        (&self.x, &self.y)
    }
}

impl Point<i32>{
    fn multiply(&self) -> i32{
        self.x * self.y
    }
}

impl Point<&str>{
    fn concat(&self) -> String{
        String::from(self.x) + self.y
    }
}

trait Summary {
    fn summarize(&self) -> String{
        let (author, main) = self.get_summary_content();
        format!("From: {}, {}", author, main)
    }
    fn get_summary_content(&self) -> (&String, &String);
}

struct NewsArticle {
    headline: String,
    body: String,
    author: String,
    date: String,
}

impl Summary for NewsArticle {
    fn get_summary_content(&self) -> (&String, &String){
        return (&self.author, &self.headline);
    }
}

struct Video {
    title: String,
    video: String,
    description: String,
    creator: String,
}

impl Summary for Video {
    fn get_summary_content(&self) -> (&String, &String){
        return (&self.creator, &self.title);
    }
}

fn push_notification(item: &impl Summary){
    println!("one new notification: {}", item.summarize());
}

//could also be written as
// fn push_notification<T: Summary>(item: &T){
//     println!("One new notification: {}", item.summarize());
// }