

import UIKit

class AddReviewTableViewController: UITableViewController, UITextViewDelegate {

    @IBOutlet weak var headerMessageCell: AddReviewTableViewCell!
    @IBOutlet weak var punctionalityAndTimingRating: RatingControl!
    @IBOutlet weak var couertosnessAndMannersRating: RatingControl!
    @IBOutlet weak var performanceAndKnowledgeRating: RatingControl!
    @IBOutlet weak var overallSatisfactionRating: RatingControl!
    @IBOutlet weak var publicReviewCell: AddReviewEditableTableViewCell!
    @IBOutlet weak var trainerFeedbackCell: AddReviewEditableTableViewCell!
    @IBOutlet weak var privateFeedbackCell: AddReviewEditableTableViewCell!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    var session: UISessionModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor.clear
        tableView.estimatedRowHeight = 44
        
        publicReviewCell.textView.textColor = hexStringToUIColor(hex: "8F8F92")
        publicReviewCell.textView.tag = 100200
        
        trainerFeedbackCell.textView.textColor = hexStringToUIColor(hex: "8F8F92")
        trainerFeedbackCell.textView.tag = 100201
        
        privateFeedbackCell.textView.textColor = hexStringToUIColor(hex: "8F8F92")
        privateFeedbackCell.textView.tag = 100202
        
        publicReviewCell.textView.text! = "Enter text"
        trainerFeedbackCell.textView.text! = "Write trainer feedback"
        privateFeedbackCell.textView.text! = "Write private feedback"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: .UIKeyboardDidHide, object: nil)
        
    
        publicReviewCell.textView.delegate = self
        trainerFeedbackCell.textView.delegate = self
        privateFeedbackCell.textView.delegate = self
        
        setupContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            // add review item
            return UITableViewAutomaticDimension
        } else if indexPath.section == 0 && (indexPath.row == 7 || indexPath.row == 9 || indexPath.row == 11) {
            // add review editable item
            return UITableViewAutomaticDimension
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }

    @IBAction func doneButtonPressed() {
        publicReviewCell.textView.resignFirstResponder()
        trainerFeedbackCell.textView.resignFirstResponder()
        privateFeedbackCell.textView.resignFirstResponder()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        // validate input

        if validateInput() != nil {
            let alert = UIAlertController(title: "Check your input", message: "All fields must be filled with a feedback", preferredStyle: .alert)
            alert.view.tintColor = hexStringToUIColor(hex: greenColor)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        showAlert()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == hexStringToUIColor(hex: "8F8F92") {
            textView.text = nil
            textView.textColor = hexStringToUIColor(hex: "8F8F93")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            switch textView.tag {
            case 100200:
                textView.text = "Enter text"
            case 100201:
                textView.text = "Write trainer feedback"
            case 100202:
                textView.text = "Write private feedback"
            default:
                break
            }
            textView.textColor = hexStringToUIColor(hex: "8F8F92")
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        doneBarButton.isEnabled = true
    }
    
    func keyboardDidHide(notification: NSNotification) {
        doneBarButton.isEnabled = false
    }
    
    private func setupContent() {
        
        if let session = session {
            headerMessageCell.label.text! = "For your training session on \(session.day) with \(session.trainer.fullName), please take a moment to let up know how your trainer did and if you have any feedback for him or us"
            
            
            if let review = session.review {
                punctionalityAndTimingRating.rating = review.punctionalityAndTiming
                couertosnessAndMannersRating.rating = review.couertosnessAndManners
                performanceAndKnowledgeRating.rating = review.performanceAndKnowledge
                overallSatisfactionRating.rating = review.overallSatisfaction
                publicReviewCell.textView!.text! = review.publicReview
                trainerFeedbackCell.textView!.text! = review.trainerFeedback
                privateFeedbackCell.textView!.text! = review.privateFeedback
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "TRAINR", message: "Thank you for your feedback", preferredStyle: .alert)
        alert.view.tintColor = hexStringToUIColor(hex: greenColor)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func validateInput() -> String? {
        if let error = validateIsEmpty(publicReviewCell.textView.text) {
            return error
        }
        
        if let error = validateIsEmpty(privateFeedbackCell.textView.text) {
            return error
        }
        
        if let error = validateIsEmpty(trainerFeedbackCell.textView.text) {
            return error
        }
        
        return nil
    }
}
