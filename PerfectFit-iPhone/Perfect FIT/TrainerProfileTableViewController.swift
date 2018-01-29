

import UIKit

class TrainerProfileTableViewController: UITableViewController, TrainerCalendarTableViewCellDelegate {
    

    // MARK: outlets
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var trainerBookingScheduleCell: TrainerCalendarTableViewCell!
    
    // MARK: lets
    
    let ESTIMATED_ROW_HEIGHT: CGFloat = 45
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar(navigationController?.navigationBar)
        tableView.separatorColor = UIColor.clear
        tableView.estimatedRowHeight = ESTIMATED_ROW_HEIGHT
        
        trainerBookingScheduleCell.delegate = self
        
        ratingControl.rating = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 7 {
               return UITableViewAutomaticDimension
            }
            
            if indexPath.row == 9 {
               return UITableViewAutomaticDimension
            }
            
            if indexPath.row == 11 {
               return UITableViewAutomaticDimension
            }
            
            if indexPath.row == 13 {
               return UITableViewAutomaticDimension
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            if indexPath.row == 2 {
                // navigate to reviews
            
                performSegue(withIdentifier: "HistoryReviewSegue", sender: nil)
            }
            
            if indexPath.row == 13 {
                // navigate to bio
                
                performSegue(withIdentifier: "BioSegue", sender: nil)
            }
        }
    }
    
    // MARK: actions
    
    @IBAction func composeButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "DialogSegue", sender: nil)
    }
    
    
    // MARK: delegate
    
    func trainerCalendar(_ cell: TrainerCalendarTableViewCell, didSelectItemAt index: Int) {
        if let bookingScheduleController = storyboard?.instantiateViewController(withIdentifier: BookingScheduleViewController.STORYBOARD_ID) {
            
            navigationController?.pushViewController(bookingScheduleController, animated: true)
        }
    }

}
