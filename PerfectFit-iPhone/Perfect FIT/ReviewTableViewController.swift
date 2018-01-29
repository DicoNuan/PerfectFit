

import UIKit

class ReviewTableViewController: UITableViewController {

    
    @IBOutlet weak var punctionalityAndTimingRatingControl: RatingControl!
    @IBOutlet weak var couertosnessAndManngerRatingControl: RatingControl!
    @IBOutlet weak var performanceAndKnowledgeRatingControl: RatingControl!
    @IBOutlet weak var overallSatisfactionRatingControl: RatingControl!
    @IBOutlet weak var publicReviewLabel: UILabel!
    @IBOutlet weak var trainerFeedbackLabel: UILabel!
    
    var rating: UIRatingModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor.clear
        tableView.estimatedRowHeight = 44
        
        setupContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && (indexPath.row == 6 || indexPath.row == 8) {
            
            return UITableViewAutomaticDimension
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    
    private func setupContent() {
        if let rating = rating {
            title = rating.trainer.fullName
            punctionalityAndTimingRatingControl.rating = rating.punctionalityAndTiming
            couertosnessAndManngerRatingControl.rating = rating.couertosnessAndManners
            performanceAndKnowledgeRatingControl.rating = rating.performanceAndKnowledge
            overallSatisfactionRatingControl.rating = rating.overallSatisfaction
            publicReviewLabel.text! = rating.publicReview
            trainerFeedbackLabel.text! = rating.trainerFeedback
        }
    }
}
