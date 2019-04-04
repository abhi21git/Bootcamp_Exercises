import UIKit

protocol loadMore {
    func loadMoreData()
}
extension loadMore where Self: UIScrollViewDelegate {
    func loadMoreData() {
        print("Loading more data")
    }
}
