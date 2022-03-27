use std::sync::mpsc;
use std::sync::Arc;
use std::sync::Mutex;
use std::thread;

type Job = Box<dyn FnOnce() + Send + 'static>;

enum Assignment {
    Quit,
    NewJob(Job),
}

pub struct ThreadPool {
    threads: Vec<Worker>,
    sender: mpsc::Sender<Assignment>,
}

impl ThreadPool {
    pub fn new(size: usize) -> ThreadPool {
        assert!(size > 0);

        //create channel and a thread safe mutable reference to the receiver
        let (sender, receiver) = mpsc::channel();
        let receiver = Arc::new(Mutex::new(receiver));

        let threads: Vec<Worker> = (0..size)
            .map(|i| Worker::new(i, Arc::clone(&receiver)))
            .collect();

        ThreadPool { threads, sender }
    }

    pub fn execute<F>(&self, f: F)
    where
        F: FnOnce() + Send + 'static,
    {
        let job = Box::new(f);
        self.sender.send(Assignment::NewJob(job)).unwrap();
    }
}

impl Drop for ThreadPool {
    fn drop(&mut self) {
        self.threads
            .iter()
            .for_each(|_| self.sender.send(Assignment::Quit).unwrap());

        for worker in &mut self.threads {
            println!("Shutting down worker: {}", worker.id);

            if let Some(thread) = worker.thread.take() {
                thread.join().unwrap();
            }
        }
    }
}

struct Worker {
    id: usize,
    thread: Option<thread::JoinHandle<()>>,
}

impl Worker {
    fn new(id: usize, receiver: Arc<Mutex<mpsc::Receiver<Assignment>>>) -> Worker {
        Worker {
            id,
            thread: Some(thread::spawn(move || loop {
                let job = receiver.lock().unwrap().recv().unwrap();
                match job {
                    Assignment::NewJob(j) => {
                        println!("Worker {} got a job", id);
                        j();
                    }
                    Assignment::Quit => {
                        println!("Exiting thread {}", id);
                        break;
                    }
                }
            })),
        }
    }
}
