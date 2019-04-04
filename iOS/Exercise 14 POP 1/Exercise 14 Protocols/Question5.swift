import UIKit

protocol Loggable {
    func loginCheck(state: Bool, id: String, pwd: String)
}
extension Loggable {
    func loginCheck(state: Bool, id: String, pwd: String) {
        switch state {
        case true:
            UserDefaults.standard.set(id, forKey: "uid")
            UserDefaults.standard.set(pwd, forKey: "pwd")
        case false:
            UserDefaults.standard.removeObject(forKey: "uid")
            UserDefaults.standard.removeObject(forKey: "uid")
        }
    }
}

