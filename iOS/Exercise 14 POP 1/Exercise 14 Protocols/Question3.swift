import UIKit

protocol ErrorViewProtocol: AnyObject {
    func showError(errorMessage: String) -> String
}

extension ErrorViewProtocol where Self: UIViewController {
    func showError(errorMessage: String) -> String {
        //some manupulation if required
        return errorMessage
    }
}

