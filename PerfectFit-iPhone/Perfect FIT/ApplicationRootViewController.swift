

import UIKit


class ApplicationRootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // check token here
        self.tabBar.isHidden = true
        
        let isTokenValid = true
        
        if isTokenValid {
            setHome()
        } else {
            setWelcome()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func setWelcome() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "WelcomeNavigationController") {
            viewController.hidesBottomBarWhenPushed = true
            self.tabBar.isHidden = true
            self.setViewControllers([viewController], animated: true)
        }
    }

    func setHome() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "HomeTabBarController") {
            viewController.hidesBottomBarWhenPushed = true
            self.tabBar.isHidden = true
            self.setViewControllers([viewController], animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
