import UIKit

var str = "Exercise 3: Swift Basics 2"

//: # Initializers

//Question 1.1: Implement the parameterised initialisation with class or struct.
class MyClass1 {
    var entity1: String?
    var entity2: String?
    var entity3: Int?
    init(e1: String, e2: String, e3: Int) {
        self.entity1 = e1
        self.entity2 = e2
        self.entity3 = e3
    }
}

/*
 Question 1.2: Write all the Rules of initialiser in Inheritance
 Answer:
A designated initializer must call a designated initializer from its immediate superclass.
A convenience initializer must call another initializer from the same class.
A convenience initializer must ultimately call a designated initializer.
*/

//Question 1.3: Using convenience Initializers, write-down the Initializers for MOVIE class having basic
//Question 1.4: attributes like title, author, publish_date, etc.
class MOVIE {
    var title: String?
    var author: String?
    var publish_date: String?
    init(movieName : String , producer : String , date : String) {
        self.title = movieName
        self.author = producer
        self.publish_date = date
    }
    convenience init( title : String) {
        self.init(movieName: title, producer: "Richard", date: "3rd Oct")
    }
}

// calling convinince initializer
var movie1 = MOVIE(title: "John Wich")
print("\(movie1.title!), \(movie1.author!), \(movie1.publish_date!)")

//calling designated Initialiser
var movie2 = MOVIE(movieName: "Deadpool", producer: "Marvels", date: "6th Oct")
print("\(movie2.title!), \(movie2.author!), \(movie2.publish_date!)")

//Question 1.5: Declare a structure which can demonstrate the throwable Initializer
struct MyTestStruct {
    var text: String
    init() throws {
        text = try String(/*some code here*/)
    }
}

//: # Array

//Question 2.1: Create an array containing the 5 different integer values. Write are at least 4 ways to do this.
var array1 = Array<String>() //Type 1
var array2: Array<String> = [] //Type 2
var array3 = [String]() //Type 3
var array4: [String] = [] //Type 4

//Question 2.2: Create an immutable array containing 5 city names.
let cities = ["New Delhi", "Kolkata", "Mumbai", "Chennai", "Banglore"]

//Question 2.3: Create an array with city 5 city names. Later add other names like Canada, Switzerland, Spain to the end of the array in at least 2 possible ways.
var cities1 = ["Sidney", "Kolkata", "Mumbai", "Chennai", "Banglore"]
// First method
cities1.append("Canada")
cities1.append("Switzerland")
//Second Method
cities1 += ["Spain", "Germany"]

//Question 2.4: Create an array with values 14, 18, 15, 16, 23, 52, 95. Replace the values 24 & 48 at 2nd & 4th index of array
var array = [14, 18, 15, 16, 23, 52, 95]
array[2] = 24
array[4] = 48

//: # Sets
let houseAnimals: Set = ["🐶","🐱"]
let farmAnimals: Set = ["🐮", "🐓", "🐏", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

//Question 3.1: Determine whether the set of house animals is a subset of farm animals.


