import UIKit


//Question 1: Write a protocol that defines the logic for load more (this func can be empty for now and just print loading more) in its extension, but this protocol is conditionally conformed by controller if controller conform to scrollViewDelegate.
protocol loadMore {
    func loadMoreData()
}
extension loadMore where Self: UIScrollViewDelegate {
    func loadMoreData() {
        print("Loading more...")
    }
}

//Question 2: Explain the use of self,Self in protocols, Also how they differ for Static function.
//Answer 2: 'Self' is only used in protocols and static methods, it refers to the type it is confirming to. while 'self' refers to value inside the class, or type.

//Question 3: Write a generic function that takes two operand and combine them.  Example = add(1 + 1), add(1.0 + 1.0), add(Ankit + nigam)
protocol genericProtocol {
    static func +(first: Self, second: Self) -> Self
}

extension Double : genericProtocol {}
extension Float : genericProtocol {}
extension Int : genericProtocol {}
extension String : genericProtocol {}

func addTwoValues<T: genericProtocol>(_ num1: T, _ num2: T) -> T {
    return num1 + num2
}
print(addTwoValues(1, 2))
print(addTwoValues(1.3, 2.2))
print(addTwoValues("One", "Two"))


//Question 4: Write an extension on collection type to find the combined value of collection.
protocol question4 {
    func combinable(item: Any) -> Any
}
extension question4 {
    func combinable(item: Any) -> Any {
        if item is [Int] {
            //item % 2 == 0
            return item
        }
        return item
    }
}



