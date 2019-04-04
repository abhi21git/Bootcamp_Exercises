import UIKit

protocol checkLogin {
    func loginCheck(state: Bool, id: String, pwd: String)
}
extension checkLogin {
    func loginCheck(state: Bool, id: String, pwd: String) {
        switch state {
        case true:
            UserDefaults.standard.removeObject(forKey: "uid")
            UserDefaults.standard.removeObject(forKey: "uid")
        case false:
            UserDefaults.standard.set(id, forKey: "uid")
            UserDefaults.standard.set(pwd, forKey: "pwd")
        }
    }
}

