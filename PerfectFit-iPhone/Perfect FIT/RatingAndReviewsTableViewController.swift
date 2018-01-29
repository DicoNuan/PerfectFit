

import UIKit

class RatingAndReviewsTableViewController: UITableViewController {

    var ratings: [UIRatingModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor.clear
        
        // load ratings from back-end
        loadRatings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! RatingTableViewCell
        
        let model = ratings[indexPath.row]
        
        if let url = URL(string: model.trainer.imgUrl) {
            cell.avatar.kf.setImage(with: url)
        } else {
            cell.avatar.image = UIImage(named: "ic_account_circle")
        }
        
        cell.nameLabel.text! = model.trainer.fullName
        cell.rating.rating = model.average()
        cell.feedback.text! = model.trainerFeedback

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ReviewSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == "ReviewSegue" {
                if let indexPath = sender as? IndexPath {
                	let model = ratings[indexPath.row]
                    let controller = segue.destination as! ReviewTableViewController
                    controller.rating = model
                }
            }
        }
    }

    
    private func loadRatings() {
        ratings.append(UIRatingModel(trainer: UIUserModel(fullName: "Amanda Fisher", imgUrl: "https://68.media.tumblr.com/avatar_5f1f600fccb0_128.png", gender: "male", age: 123, city: "Gorodnya", weight: 123, height: 123, email: "ss@gmail.com", phoneNumber: "12938102398"), punctionalityAndTiming: -1, couertosnessAndManners: 4, performanceAndKnowledge: 1, overallSatisfaction: 7, publicReview: "Very and very nice trainer, I liked her so much. She pushed till I am done.", trainerFeedback: "Very and very nice trainer, I liked her so much. She pushed till I am done.", privateFeedback: "You are lame"))
        
        ratings.append(UIRatingModel(trainer: UIUserModel(fullName: "Dana White", imgUrl: "", gender: "male", age: 12312, city: "Kida", weight: 123, height: 123, email: "asda@gmail.com", phoneNumber: "21312312"), punctionalityAndTiming: 0, couertosnessAndManners: 2, performanceAndKnowledge: 3, overallSatisfaction: 4, publicReview: "Very and very nice trainer, I liked her so much. She pushed till I am done.", trainerFeedback: "Very and very nice trainer, I liked her so much. She pushed till I am done.", privateFeedback: "You are lame"))
        
        ratings.append(UIRatingModel(trainer: UIUserModel(fullName: "Leha Siply", imgUrl: "https://pp.userapi.com/c625616/v625616546/13a75/W71WZclZkao.jpg", gender: "male", age: 123, city: "Kidada", weight: 123, height: 123, email: "@gmail.com", phoneNumber: "123918203"), punctionalityAndTiming: 5, couertosnessAndManners: 5, performanceAndKnowledge: 5, overallSatisfaction: 5, publicReview: "Very and very nice trainer, I liked her so much. She pushed till I am done.", trainerFeedback: "Very and very nice trainer, I liked her so much. She pushed till I am done.", privateFeedback: "You are lame, but no, I lied"))
        
        
    }
    
}
