
import Foundation
import UIKit
import MBProgressHUD

@objc class Singleton: NSObject {
    
    static let _singletonInstance = Singleton()
    public static let API_KEY = "5ee467b569f1fcd89492e89e5dddad1b"
    private override init() {
       
    }
    
    @objc public class func sharedInstance() -> Singleton {
        return Singleton._singletonInstance
    }
    
    @objc public func showProgessBar(){
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            MBProgressHUD.showAdded(to: window, animated: true)
            
        }
        else {
            let window = UIApplication.shared.windows[0]
            MBProgressHUD.showAdded(to: window, animated: true)
        }
    }
    @objc public func hideProgessBar(){
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }){
            MBProgressHUD.hide(for: window, animated: true)
        }
        else {
            let window = UIApplication.shared.windows[0]
            MBProgressHUD.hide(for: window, animated: true)
        }
    }
}
