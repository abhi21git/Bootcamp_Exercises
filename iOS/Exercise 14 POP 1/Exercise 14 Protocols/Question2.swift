import UIKit

protocol Toastable {
    func showToast(toastMessage: String)
}

extension Toastable where Self: UIViewController{
    func showToast(toastMessage: String){
        let toastItem = UILabel()
        view.addSubview(toastItem)
        toastItem.layer.cornerRadius = toastItem.layer.frame.height / 2
        toastItem.backgroundColor? = .darkGray
        toastItem.textColor = .white
        toastItem.text = toastMessage
        UIView.transition(with: toastItem, duration: 3, options: .transitionCrossDissolve, animations: { toastItem.removeFromSuperview() }, completion: nil)
    }
}
