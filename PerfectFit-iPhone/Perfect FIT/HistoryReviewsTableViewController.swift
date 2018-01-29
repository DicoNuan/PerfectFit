

import UIKit

class HistoryReviewsTableViewController: UITableViewController {

    // MARK: lets
    
    let REVIEW_SEGUE_ID = "ReviewSegue"
    
    
    // MARK: vars
    
    var reviews: [UIRatingModel] = []
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadReviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryReviewTableViewCell.CELL_ID, for: indexPath) as! HistoryReviewTableViewCell
        
        let model = reviews[indexPath.row]
        
        cell.nameLabel.text = model.trainer.fullName
        cell.ratingControl.rating = model.average()
        cell.reviewLabel.text = model.publicReview
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: REVIEW_SEGUE_ID, sender: indexPath)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == REVIEW_SEGUE_ID {
                if let indexPath = sender as? IndexPath {
                    let model = reviews[indexPath.row]
                    let controller = segue.destination as! ReviewTableViewController
                    controller.rating = model
                }
            }
        }
    }
    
    // MARK: private methods
    
    private func loadReviews() {
        let user = UIUserModel(fullName: "Amanda Fisher", imgUrl: "", gender: "male", age: 26, city: "Kuwaite", weight: 153, height: 172, email: "a.fisher@gmail.net", phoneNumber: "+38052801180248")
        let model = UIRatingModel(trainer: user, punctionalityAndTiming: 4, couertosnessAndManners: 4, performanceAndKnowledge: 2, overallSatisfaction: 3, publicReview: "Jared's been back from that island for a whole day and he didn't get any toilet paper?", trainerFeedback: "Jared's been back from that island for a whole day and he didn't get any toilet paper?", privateFeedback: "Jared's been back from that island for a whole day and he didn't get any toilet paper?")
        
        reviews.append(model)
        reviews.append(model)
        reviews.append(model)
    }
}
