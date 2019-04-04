import UIKit

protocol Roundable {
    func makeRound(view: UIView)
}
extension Roundable {
    func makeRound(view: UIView) {
        view.layer.cornerRadius = view.layer.frame.height / 2
    }
    func makeRound(view: UIImageView) {
        view.layer.cornerRadius = view.layer.frame.height / 2
    }
}

protocol Borderable {
    func addBorder(view: UIView)
}
extension Borderable {
    func addBorder(view: UIView) {
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
    }
    func addBorder(view: UIImageView) {
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
    }
}

