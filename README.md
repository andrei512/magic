magic
=====

A `NSObject` extension written in swift that gives a general implementation for loading data from a JSON and converting an object to a `NSDictionary`.

More details in [this]() article by [We ❤ Swift](http://www.weheartswift.com/).

# Usage

Copy `magic.swift` into your project.

```swift
let info = [
    "first_name": "Andrei",
    "last_name": "Puni",
    "age": 23
]

var user = User.fromJson(info)

println(user.firstName) // "Andrei"
println(user.lastName) // "Puni"
println(user.age) // 23

println(user.asJson())
//{
//    age = 23;
//    firstName = Andrei;
//    lastName = Puni;
//}
```
