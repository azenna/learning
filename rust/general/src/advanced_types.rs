

//type aliases
type Kilometers = i32;

//types can be used to reduce long type signatures
// Box<Option<Vec<T>>>
type my_type<T> = Box<Result<Vec<T>>>
// the longtype can now just be used as my_type<whatever>