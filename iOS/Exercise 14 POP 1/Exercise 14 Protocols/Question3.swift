import UIKit

protocol ErrorViewProtocol: class {
    func showError(errorMessage: String) -> String
}

extension ErrorViewProtocol where Self: UIViewController {
    func showError(errorMessage: String) -> String {
        //some manupulation if required
        return errorMessage
    }
}

