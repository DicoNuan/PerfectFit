

import UIKit

class MedicalHistoryViewController: UIViewController {

    @IBOutlet weak var medicalHistoryTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        medicalHistoryTextView.isEditable = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func editButtonPressed(_ sender: Any) {
        medicalHistoryTextView.isEditable = !medicalHistoryTextView.isEditable
        
        if medicalHistoryTextView.isEditable {
            view.endEditing(true)
        } else {
            medicalHistoryTextView.becomeFirstResponder()
        }
    }
   

}
