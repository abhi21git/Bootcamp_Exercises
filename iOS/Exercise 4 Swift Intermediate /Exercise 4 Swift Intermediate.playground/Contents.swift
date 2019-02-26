import UIKit

var str = "Exercise 4: Swift Intermediate"

//Question 1: Write a function called siftBeans(fromGroceryList:) that takes a grocery list (as an array of strings) and “sifts out” the beans from the other groceries. The function should take one argument that has a parameter name called list, and it should return a named tuple of the type (beans: [String], otherGroceries: [String]).
var list : [String] = ["green beans", "banana", "black beans", "grapes", "red beans", "apples", "carrot"]
func siftBeans( fromGroceryList : [String] ) -> (beans : [String] , otherGroceries :[String]) {
    var beans = [String]()
    var otherGroc = [String]()
    for groceryItem in list {
        if (groceryItem.hasSuffix("beans")) {
            beans.append(groceryItem)
        }
        else {
            otherGroc.append(groceryItem)
        }
    }
    return (beans , otherGroc)
}
var  result = siftBeans(fromGroceryList: list)
print(result.beans,"are beans.")
print(result.otherGroceries,"are other groceries")
