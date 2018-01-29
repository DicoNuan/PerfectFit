
import UIKit
import Kingfisher

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var userInfoCell: UserInfoTableViewCell!
    
    var user: UIUserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(navigationController?.navigationBar)
        
        // load user from back-end
        loadUser()
        
        if let url = URL(string: user.imgUrl) {
            userInfoCell.avatar.kf.setImage(with: url)
        } else {
            userInfoCell.avatar.image = UIImage(named: "ic_account_circle")
        }
        userInfoCell.name.text! = user.fullName
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }


    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            // navigate to profile
            
            if let profileSettingsController = storyboard?.instantiateViewController(withIdentifier: "ProfileSettingTableViewController") as? ProfileSettingTableViewController {
                profileSettingsController.hidesBottomBarWhenPushed = true
                profileSettingsController.user = user
                navigationController?.pushViewController(profileSettingsController, animated: true)
            }
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                // navigate to session tracking
                
                if let sessionTrackingController = storyboard?.instantiateViewController(withIdentifier: "SessionTrackingViewController") as? SessionTrackingViewController {
                    sessionTrackingController.hidesBottomBarWhenPushed = true
                    navigationController?.pushViewController(sessionTrackingController, animated: true)
                }
                
            }
            
            if indexPath.row == 1 {
                // navigate to ratings and reviews
                if let ratingAndReviewsController = storyboard?.instantiateViewController(withIdentifier: "RatingAndReviewsTableViewController") as?  RatingAndReviewsTableViewController {
                    ratingAndReviewsController.hidesBottomBarWhenPushed = true
                    navigationController?.pushViewController(ratingAndReviewsController, animated: true)
                }
                
            }
            
            if indexPath.row == 2 {
               // navigate to payment history
                
                if let paymentHistoryController = storyboard?.instantiateViewController(withIdentifier: "PaymentHistoryTableViewController") as? PaymentHistoryTableViewController {
                    paymentHistoryController.hidesBottomBarWhenPushed = true
                    navigationController?.pushViewController(paymentHistoryController, animated: true)
                }
    
            }
        }
        
        if indexPath.section == 2 && indexPath.row == 0 {
            // navigate to become a trainer
            
            if let becomeTrainerController = storyboard?.instantiateViewController(withIdentifier: "BecomeATrainerViewController") as? BecomeATrainerViewController {
                becomeTrainerController.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(becomeTrainerController, animated: true)
            }
            
        }
    }
    
    
    @IBAction func onMenuButtonPressed() {
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        menu.view.tintColor = hexStringToUIColor(hex: greenColor)
        
        menu.addAction(UIAlertAction(title: "Log out", style: .default, handler: {
            action in
            // log-out implement
            
            AppDelegate.getApplicationTabBarController()?.setWelcome()
        }))
        
        menu.addAction(UIAlertAction(title: "Delete account", style: .destructive, handler: {
            action in
            // delete account implement
            
        }))
        
        menu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(menu, animated: true, completion: nil)
    }
  
    
    
    private func loadUser() {
        user = UIUserModel(fullName: "Andrey Prokhorenko", imgUrl: "", gender: "male", age: 10, city: "Chernihiv", weight: 60.0, height: 172.0, email: "p@gm.com", phoneNumber: "+380 (500) 123-1234")
    }
}
