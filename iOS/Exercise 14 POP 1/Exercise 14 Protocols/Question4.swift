import UIKit

protocol loading: AnyObject {
    func activityLoader(loader: UIActivityIndicatorView)
}

extension loading {
    func activityLoader(loader: UIActivityIndicatorView) {
        switch loader.isHidden {
        case true:
            loader.isHidden = false
            loader.startAnimating()
        case false:
            loader.isHidden = true
            loader.stopAnimating()
        }
    }
}
