import UIKit

var str = "Exercise 4: Swift Intermediate"

//Question 1: Write a function called siftBeans(fromGroceryList:) that takes a grocery list (as an array of strings) and “sifts out” the beans from the other groceries. The function should take one argument that has a parameter name called list, and it should return a named tuple of the type (beans: [String], otherGroceries: [String]).
var list : [String] = ["green beans", "banana", "black beans", "grapes", "red beans", "apples", "carrot"]
func siftBeans( fromGroceryList : [String] ) -> (beans : [String] , otherGroceries :[String]) {
    var beans = [String]()
    var otherGrocery = [String]()
    for groceryItem in list {
        if (groceryItem.hasSuffix("beans")) {
            beans.append(groceryItem)
        }
        else {
            otherGrocery.append(groceryItem)
        }
    }
    return (beans , otherGrocery)
}
var  result = siftBeans(fromGroceryList: list)
print(result.beans,"are beans.")
print(result.otherGroceries,"are other groceries")

//Question 2.1: Make a calculator class with a function name “equals” that take a enum case as value like multiply, subtraction, addition, square root, division.
indirect enum Calculator {
    case number(Float)
    case addition(Calculator, Calculator)
    case substraction(Calculator, Calculator)
    case multiplication(Calculator, Calculator)
    case division(Calculator, Calculator)
    case sqroot(Calculator)
}
func equals(_ operation: Calculator) -> Float {
    switch operation {
    case let .number(value):
        return value
    case let .addition(num1, num2):
        return equals(num1) + equals(num2)
    case let .substraction(num1, num2):
        return equals(num1) - equals(num2)
    case let .multiplication(num1, num2):
        return equals(num1) * equals(num2)
    case let .division(num1, num2):
        return equals(num1) / equals(num2)
    case let .sqroot(num1):
        return sqrt(equals(num1))
    }
}
var num1 = (Calculator.number(25))
var num2 = (Calculator.number(5))
print("\nFor \(num1) and \(num2)\nAddition is \(equals(Calculator.addition(num1, num2)))\nSubtraaction is \(equals(Calculator.substraction(num1, num2)))\nMultiplication is \(equals(Calculator.multiplication(num1, num2)))\nDivision is \(equals(Calculator.division(num1, num2)))\nSquare root is \(equals(Calculator.sqroot(num1)))")

//Question 2.2: Make same calculator using functions as argument, define all type functions in a struct.

