import UIKit

var str = "Exercise 6: Swift Intermediate Error Handling"

//Question 1: What is Error Protocol. Create a custom error conforming to error protocol.
//Answer: Error Protocol is just a type for representing error values that can be thrown.
enum UserDetailError: Error {
    case noValidName
    case noValidAge
}

//Question 2: Write a failable initialiser for a class which throws a error  “Object not able to initialise” description a initialisationFailed case, Catch the error and print its error description.

