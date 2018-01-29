

import UIKit
import XLPagerTabStrip
import SwiftEventBus

class BookingScheduleViewController: ButtonBarPagerTabStripViewController {
    
    
    // MARK outlets
    
    @IBOutlet weak var dayPickerCollectionView: BookingCalendarCollectionView!
    
    // MARK: lets
    static let STORYBOARD_ID = "BookingScheduleViewController"
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        // change selected bar color
        setupTabLayout()
        
        if let navigationController = self.navigationController {
            
            let navigationBar = navigationController.navigationBar
            let navBorder: UIView = UIView(frame: CGRect(x: 0, y: navigationBar.frame.size.height, width: navigationBar.frame.size.width, height: 1))
            // Set the color you want here
            navBorder.backgroundColor = hexStringToUIColor(hex: navigationBarBlack)
            navBorder.isOpaque = true
            self.navigationController?.navigationBar.addSubview(navBorder)
        }
        
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let controllers = getDisplayControllers()
    
        return controllers
    }
    
    // MARK: delegate methods
    


    
    // MARK: private methods
    
    
    private func setupTabLayout() {
        settings.style.buttonBarBackgroundColor = hexStringToUIColor(hex: navigationBarBlack)
        settings.style.buttonBarItemBackgroundColor = hexStringToUIColor(hex: navigationBarBlack)
        settings.style.selectedBarBackgroundColor = hexStringToUIColor(hex: greenColor)
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = hexStringToUIColor(hex: greenColor)
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = hexStringToUIColor(hex: greenColor)
            newCell?.label.textColor = hexStringToUIColor(hex: greenColor)
        }
    }

    
    private func getDisplayControllers() -> [BookingScheduleChildViewController] {
        let janController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingCalendarChildViewControllerID") as! BookingScheduleChildViewController
        
        janController.tabTitle = "January"
        janController.numberOfDaysInMonth = 30
        
        let febController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingCalendarChildViewControllerID") as! BookingScheduleChildViewController
        
        febController.tabTitle = "February"
        
        let marController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingCalendarChildViewControllerID") as! BookingScheduleChildViewController
        
        marController.tabTitle = "March"
        
        let aprController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingCalendarChildViewControllerID") as! BookingScheduleChildViewController
        
        aprController.tabTitle = "April"
        
        let mayController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingCalendarChildViewControllerID") as! BookingScheduleChildViewController
        
        mayController.tabTitle = "May"
        
        let junController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingCalendarChildViewControllerID") as! BookingScheduleChildViewController
        
        junController.tabTitle = "June"
        
        let julController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingCalendarChildViewControllerID") as! BookingScheduleChildViewController
        
        julController.tabTitle = "July"
        
        let augController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingCalendarChildViewControllerID") as! BookingScheduleChildViewController
        
        augController.tabTitle = "August"
        
        let sepController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingCalendarChildViewControllerID") as! BookingScheduleChildViewController
        
        sepController.tabTitle = "September"
        
        let octController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingCalendarChildViewControllerID") as! BookingScheduleChildViewController
        
        octController.tabTitle = "October"
        
        let novController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingCalendarChildViewControllerID") as! BookingScheduleChildViewController
        
        novController.tabTitle = "November"
        
        let decController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingCalendarChildViewControllerID") as! BookingScheduleChildViewController
        
        decController.tabTitle = "December"
        
        return [janController, febController, marController, aprController, mayController, junController, julController, augController, sepController, octController, novController, decController]
    }
}
