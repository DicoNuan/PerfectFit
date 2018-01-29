

import UIKit

class TrackingInfoTableViewController: UITableViewController {

    @IBOutlet weak var trainerInfoCell: TrackingInfoUserTableViewCell!
    @IBOutlet weak var addReviewControl: RatingControl!
    @IBOutlet weak var addReviewLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    
    var session: UISessionModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.5
        } else {
            return super.tableView(tableView, heightForHeaderInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            // navigate to trainer info
            
            performSegue(withIdentifier: "TrainerSegue", sender: nil)
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                // navigate to AddReview
                performSegue(withIdentifier: "AddReviewSegue", sender: nil)
            }
            
            if indexPath.row == 6 {
                // navigate to ModifySession
                performSegue(withIdentifier: "ModifySessionSegue", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == "AddReviewSegue" {
                let controller = segue.destination as! AddReviewTableViewController
                controller.session = session
            }
        }
    }
    
    
    private func setupContent() {
        if let session = session {
            if let url = URL(string: session.trainer.imgUrl) {
                trainerInfoCell.avatar.kf.setImage(with: url)
            } else {
                trainerInfoCell.avatar.image = UIImage(named: "ic_account_circle")
            }
            trainerInfoCell.nameLabel.text! = session.trainer.fullName
            trainerInfoCell.activityLabel.text! = session.trainer.activity
            
            if let review = session.review {
                addReviewLabel.isHidden = true
                addReviewControl.isHidden = false
                addReviewControl.rating = review.average()
            } else {
                addReviewLabel.isHidden = false
                addReviewControl.isHidden = true
            }
            
            dayLabel.text! = session.day
            hoursLabel.text! = session.length
            activityLabel.text! = session.trainer.activity
            priceLabel.text! = "\(session.payment.sumPayed)" + session.payment.currencyPayed
            paymentMethodLabel.text! = session.payment.paymentMethod
        }
    }

}
