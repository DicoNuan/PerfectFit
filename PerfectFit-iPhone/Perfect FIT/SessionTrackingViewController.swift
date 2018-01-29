

import UIKit

class SessionTrackingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var sessions: [UISessionModel] = []
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load sessions from back-end
        loadSessions()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == "TrackingInfoSegue" {
                if let indexPath = sender as? IndexPath {
                    let model = sessions[indexPath.row]
                    let controller = segue.destination as! TrackingInfoTableViewController
                    controller.session = model
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionTableViewCell", for: indexPath) as! SessionTableViewCell
        
        let model = sessions[indexPath.row]
        
        cell.trainerLabel.text! = model.trainer.fullName
        cell.sessionLabel.text! = model.trainer.activity
        cell.dayLabel.text! = model.day
        cell.hoursLabel.text! = model.hours[0] + " - " + model.hours[1]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "TrackingInfoSegue", sender: indexPath)
    }
 
    @IBAction func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("filter new sessions")
        case 1:
            print("filter ended sessions")
        default:
            break
        }
    }
    
    private func loadSessions() {
        let trainer = UITrainerModel(fullName: "Amanda Fisher", imgUrl: "", gender: "male", age: 123, city: "Kida", weight: 123, height: 123, email: "makl@gmail.com", phoneNumber: "123123312", activity: "Trainer")
        let review = UIRatingModel(trainer: trainer, punctionalityAndTiming: 5, couertosnessAndManners: 2, performanceAndKnowledge: 3, overallSatisfaction: 4, publicReview: "Kinda ok", trainerFeedback: "Excellent", privateFeedback: "Awful")
        
        sessions.append(UISessionModel(trainer: trainer, review: nil, day: "10 Nov", hours: ["12:00", "15:00"], length: "2 hours", payment: UIPaymentModel(whomPayed: trainer, paymentMethod: "Visa", sumPayed: 1005, currencyPayed: "KD", dayPayed: "11 Oct", hoursPayed: ["12:00", "15:00"])))
        
        sessions.append(UISessionModel(trainer: trainer, review: review, day: "10 Oct", hours: ["10:00", "11:00"], length: "1 hour", payment: UIPaymentModel(whomPayed: trainer, paymentMethod: "MasterCard", sumPayed: 1005, currencyPayed: "KD", dayPayed: "11 Oct", hoursPayed: ["10:00", "11:00"])))
        
        sessions.append(UISessionModel(trainer: trainer, review: review, day: "10 Oct", hours: ["10:00", "11:00"], length: "1 hour", payment: UIPaymentModel(whomPayed: trainer, paymentMethod: "MasterCard", sumPayed: 1005, currencyPayed: "KD", dayPayed: "11 Oct", hoursPayed: ["10:00", "11:00"])))
        
        sessions.append(UISessionModel(trainer: trainer, review: nil, day: "10 Oct", hours: ["10:00", "11:00"], length: "1 hour", payment: UIPaymentModel(whomPayed: trainer, paymentMethod: "MasterCard", sumPayed: 1005, currencyPayed: "KD", dayPayed: "11 Oct", hoursPayed: ["10:00", "11:00"])))
        
        
    }
}
