

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func showTabs() {
        self.tabBar.isHidden = false
    }
    
    func hideTabs() {
        self.tabBar.isHidden = true
    }

}
